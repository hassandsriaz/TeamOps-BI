import mysql.connector
from mysql.connector import Error
import streamlit as st

def connect_to_database():
    try:
        connection = mysql.connector.connect(
            host='192.168.100.237',
            database='team_management_v2',
            user='remote',
            password='hamza123'
        )
        
        if connection.is_connected():
            print("Connected to MySQL database")
            return connection
    
    except Error as e:
        print("Error while connecting to MySQL", e)
        return None

connection = connect_to_database()

def add_developer(name, age, connection):
    try:
        if connection is not None:
            cursor = connection.cursor()
            insert_query = "INSERT INTO developer (Name, Age) VALUES (%s,%s)"
            cursor.execute(insert_query, (name, age))
            devid = cursor.lastrowid
            insert_ongoing_query = """
            INSERT INTO ongoing (devid, burden, sum_weight, total_project_type, num_of_projects)
            VALUES (%s, 0.00, 0.00, 0.00, 0)
            """
            cursor.execute(insert_ongoing_query, (devid,))

            insert_completed_query = """
            INSERT INTO completed (devid, avg_dev_rating, performance, sum_rating, num_of_projects, total_project_type, avg_project_weight)
            VALUES (%s, 0.00, 0.00, 0.00, 0, 0.00, 0.00)
            """
            cursor.execute(insert_completed_query, (devid,))
            connection.commit()
            st.success(f"Developer {name} added successfully.")
        
        else:
            st.error("Failed to connect to the database.")
    
    except Exception as e:
        st.error(f"Error while adding developer: {e}")
    
    finally:
        if connection is not None and connection.is_connected():
            cursor.close()

def add_project(name,type, rating, developers, connection):
    try:
        if connection is not None:
            cursor = connection.cursor()
            insert_query = "INSERT INTO Project (TYPE, Rating,proj_name) VALUES (%s, %s,%s)"
            cursor.execute(insert_query, (type, rating,name))
            pid = cursor.lastrowid
            connection.commit()
            st.success(f"Project with name {name} added successfully.")

            for dev_id, contrib,names in developers:
                insert_progress_query = "INSERT INTO Progress (devid, pid, progress_weight, general_weight) VALUES (%s, %s, %s, %s)"
                cursor.execute(insert_progress_query, (dev_id, pid, contrib * type, contrib))
                connection.commit()
                st.success(f"Added developer {names} with contribution {contrib} to project {name}.")

                fetch_ongoing_query = "SELECT burden, sum_weight, total_project_type, num_of_projects FROM ongoing WHERE devid = %s"
                cursor.execute(fetch_ongoing_query, (dev_id,))
                ongoing = cursor.fetchone()

                if ongoing:
                    burden, sum_weight, total_project_type, num_of_projects= ongoing
                else:
                    burden = sum_weight = total_project_type = 0.00
                    num_of_projects = 0

                sum_weight += contrib * type
                total_project_type += type
                burden = sum_weight / total_project_type
                num_of_projects += 1    

                update_ongoing_query = """
                UPDATE ongoing
                SET burden = %s, sum_weight = %s, total_project_type = %s, num_of_projects = %s
                WHERE devid = %s
                """
                cursor.execute(update_ongoing_query, (burden, sum_weight, total_project_type, num_of_projects,dev_id))
                connection.commit()

        else:
            st.error("Failed to connect to the database.")

    except Error as e:
        st.error(f"Error while adding project: {e}")

    finally:
        if connection is not None and connection.is_connected():
            cursor.close()

def submit_project(pid, rating, connection):
    try:
        if connection is not None:
            cursor = connection.cursor()
            update_project_query = "UPDATE project SET Rating = %s WHERE PID = %s"
            cursor.execute(update_project_query, (rating, pid))
            connection.commit()

            fetch_progress_query = "SELECT devid, progress_weight FROM progress WHERE pid = %s"
            cursor.execute(fetch_progress_query, (pid,))
            progress_data = cursor.fetchall()

            fetch_type_query = "SELECT TYPE FROM project WHERE pid = %s"
            cursor.execute(fetch_type_query, (pid,))
            project_type = cursor.fetchone()[0]
            
            for progress in progress_data:
                devid, progress_weight = progress

                fetch_ongoing_query = "SELECT burden, sum_weight, total_project_type, num_of_projects FROM ongoing WHERE devid = %s"
                cursor.execute(fetch_ongoing_query, (devid,))
                ongoing = cursor.fetchone()

                if ongoing:
                    burden, sum_weight, total_project_type, num_of_projects= ongoing
                    
                    num_of_projects -= 1
                    total_project_type -= project_type
                    sum_weight -= progress_weight
                    burden = sum_weight / total_project_type if total_project_type != 0 else 0
                    
                    

                    update_ongoing_query = """
                    UPDATE ongoing
                    SET burden = %s, sum_weight = %s, total_project_type = %s, num_of_projects = %s
                    WHERE devid = %s
                    """
                    cursor.execute(update_ongoing_query, (burden, sum_weight, total_project_type, num_of_projects, devid))
                    connection.commit()

                    fetch_completed_query = "SELECT avg_dev_rating, performance, sum_rating, num_of_projects, total_project_type, avg_project_weight FROM completed WHERE devid = %s"
                    cursor.execute(fetch_completed_query, (devid,))
                    completed = cursor.fetchone()
                    
                    if completed:
                        avg_dev_rating, performance, sum_rating, num_of_projects, total_project_type, avg_project_weight1  = completed
    
                        num_of_projects += 1
                        sum_rating += rating
                        total_project_type += project_type
                        avg_dev_rating = sum_rating / num_of_projects
                        performance += progress_weight * rating
                        avg_project_weight1=total_project_type/num_of_projects
                        
                        
    
                        update_completed_query = """
                        UPDATE completed
                        SET avg_dev_rating = %s, performance = %s, sum_rating = %s, num_of_projects = %s, 
                        total_project_type = %s, avg_project_weight = %s
                        WHERE devid = %s
                        """
                        cursor.execute(update_completed_query, (avg_dev_rating, performance, sum_rating, num_of_projects, total_project_type, avg_project_weight1, devid))
                        connection.commit()

                        delete_progress_query = "DELETE FROM progress WHERE pid = %s"
                        cursor.execute(delete_progress_query, (pid,))
                        connection.commit()
    
            st.success(f"Project {pid} with rating {rating} submitted successfully.")

        else:
            st.error("Failed to connect to the database.")

    except Exception as e:
        st.error(f"Error while submitting project: {e}")

    finally:
        if connection is not None and connection.is_connected():
            cursor.close()

st.set_page_config(page_title="Developer and Project Management", layout="wide")



# Page names
pages = ["Home Page", "Add Developer", "Add Project", "Submit Project"]

# Create a container in the sidebar for tiles
tiles_container = st.sidebar.container()

# Initialize session state for selected page if not already set
if 'selected_page' not in st.session_state:
    st.session_state.selected_page = "Home Page"

# Display tiles
for page in pages:
    if st.sidebar.button(page):
        st.session_state.selected_page = page
   

# Use st.session_state.selected_page to control the current page displayed
page = st.session_state.selected_page

st.title("Developer and Project Management")

if page == "Home Page":
    st.header("Welcome to the Developer and Project Management System")

elif page == "Add Developer":
    st.header("Add Developer to Our Company Records")
    name = st.text_input("Name")
    age = st.number_input("Age", min_value=18, max_value=60)
    
    if st.button("Add Developer", key=123):
        try:
            if connection is not None:
                cursor = connection.cursor()
                
                # Check if developer with the same name already exists
                check_query_name = "SELECT COUNT(*) FROM Developer WHERE Name = %s"
                cursor.execute(check_query_name, (name,))
                count1 = cursor.fetchone()[0]
                
                if count1 > 0:
                    # Get the last row ID and increment it by 1
                    cursor.execute("SELECT MAX(Devid) FROM Developer")
                    last_id = cursor.fetchone()[0]
                    new_id = last_id + 1 if last_id is not None else 1
                    st.success(f"User with this name exists! You are now identified by {name} - Developer ID {new_id}")
                    add_developer(name, age, connection)
                    
            else:
                st.error("Failed to connect to the database.")
        except Exception as e:
            st.error(f"Error while checking developer: {e}")


            

elif page == "Add Project":
    
    
    developers = []
    total_contribution = 0.0
    
    # Fetch developer names and IDs from the database
    developer_options = {}
    st.header("Add Project")
    Project_name = st.text_input("Project Name")
    type = st.slider(label="Type",min_value=0.10,max_value=1.00,step=0.1)
    num_developers = st.number_input("Number of Developers", min_value=1, step=1)
    try:
        if connection is not None:
            cursor = connection.cursor()
            cursor.execute("SELECT devid, name FROM Developer")
            rows = cursor.fetchall()
            for row in rows:
                developer_id, developer_name = row
                developer_options[developer_name] = developer_id
            
                    
                
                
        else:
            st.error("Failed to connect to the database.")
    except Exception as e:
        st.error(f"Error fetching developers: {e}")
    
    st.subheader("Enter Developer IDs and Contributions")
    for i in range(num_developers):
        st.write(f"Developer {i+1}")
        developer_name = st.selectbox(f"Select Developer", options=list(developer_options.keys()), key=2*i)
        contribution = st.number_input(f"Contribution", min_value=0.00, max_value=1.00, value=0.00, key=2*i+1)
        
        try:
            dev_id = developer_options[developer_name]

            if contribution < 0 or contribution > 1:
                st.error("Contribution must be between 0 and 1.")
                break

            if total_contribution + contribution > 1:
                st.error("Total contribution of all developers must not exceed 1.")
                break

            total_contribution += contribution
            developers.append((dev_id, contribution,developer_name))

        except ValueError:
            st.error("Invalid input. Please enter numeric values for Developer ID and Contribution.")
            break

    if st.button("Process Developers"):
        mapp = set()
        check = True
        for i, cont,name in developers:
            if i in mapp:
                st.error("Duplicate Developer ID")
                check = False
            mapp.add(i)
           
        if len(developers) == num_developers and total_contribution == 1 and check:
            total = 0
            for developer in developers:
                dev_id = developer[0]
                name=developer[2]
                try:
                    if connection is not None:
                        cursor = connection.cursor()
                        check_query = "SELECT COUNT(*) FROM Developer WHERE devid = %s"
                        cursor.execute(check_query, (dev_id,))
                        count = cursor.fetchone()[0]
                        total += count
                        check_query = "SELECT COUNT(*) FROM project WHERE proj_name = %s"
                        cursor.execute(check_query, (Project_name,))
                        count1 = cursor.fetchone()[0]
                        if count1==1:
                            st.error("Project name already exists")
                            break
                        elif count > 0:
                            st.success(f"Developer with name {name} exists.")

                        else:
                            st.error(f"Developer with name {name} does not exist.")
                    else:
                        st.error("Failed to connect to the database.")
                except Exception as e:
                    st.error(f"Error while checking developer: {e}")
            if total == num_developers and count1==0:
                add_project(Project_name,type, 0, developers, connection)
        else:
            st.error("Please ensure all developer information is entered correctly. Total Contribution must be equal to 1")


elif page == "Submit Project":
    # st.header("Submit Project")
    with st.form("submit_project_form"):
        pid = st.number_input("Project ID", min_value=1)
        rating = st.slider("Rating", min_value=1, max_value=5)
        submitted = st.form_submit_button("Submit Project")
        if submitted:
            try:
                if connection is not None:
                    cursor = connection.cursor()
                    check_query = "SELECT COUNT(*) FROM project WHERE pid = %s"
                    cursor.execute(check_query, (pid,))
                    count = cursor.fetchone()[0]
                    check_query1 = "SELECT COUNT(*) FROM progress WHERE pid = %s"
                    cursor.execute(check_query1, (pid,))
                    count1 = cursor.fetchone()[0]
                    
                    if count > 0 and count1 > 0:
                        submit_project(pid, rating, connection)
                    elif count <= 0:
                        st.error(f"Project with ID {pid} does not exist.")
                    else:
                        st.error(f"Project with ID {pid} has already been submitted.")
                else:
                    st.error("Failed to connect to the database.")
            except Exception as e:
                st.error(f"Error while checking developer: {e}")

if connection is not None and connection.is_connected():
    connection.close()