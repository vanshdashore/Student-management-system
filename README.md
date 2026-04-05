import mysql.connector

# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Admin123",
    database="student_db"
)

cursor = conn.cursor()

# ---------------- FUNCTIONS ---------------- #

def add_student():
    name = input("Enter Name: ")
    roll = int(input("Enter Roll No: "))
    branch = input("Enter Branch: ")
    cgpa = float(input("Enter CGPA: "))
    skills = input("Enter Skills (comma separated): ")

    query = "INSERT INTO students (name, roll_no, branch, cgpa, skills) VALUES (%s, %s, %s, %s, %s)"
    values = (name, roll, branch, cgpa, skills)

    cursor.execute(query, values)
    conn.commit()                       #permanent krta data ko save, system band hone pe gayab nhi hoga

    print("✅ Student Added Successfully\n")


def view_students():
    cursor.execute("SELECT * FROM students")
    data = cursor.fetchall()

    print("\n--- Student Records ---")
    for row in data:
        print(row)
    print()


def search_student():
    roll = int(input("Enter Roll No to Search: "))
    query = "SELECT * FROM students WHERE roll_no = %s"
    cursor.execute(query, (roll,))
    result = cursor.fetchone()

    if result:
        print("✅ Found: ", result)
    else:
        print("❌ Student Not Found")
    print()


def delete_student():
    roll = int(input("Enter Roll No to Delete: "))
    query = "DELETE FROM students WHERE roll_no = %s"
    cursor.execute(query, (roll,))       #(roll)-> int; (roll,) -> tupple;  execute() need tupple
    conn.commit()                        #permanent krta data ko save, system band hone pe gayab nhi hoga

    print("🗑️ Student Deleted\n")


def update_student():
    roll = int(input("Enter Roll No to Update: "))
    new_cgpa = float(input("Enter New CGPA: "))

    query = "UPDATE students SET cgpa = %s WHERE roll_no = %s"
    cursor.execute(query, (new_cgpa, roll))
    conn.commit()                        #permanent krta data ko save

    print("✏️ Student Updated\n")


# ---------------- ANALYTICS ---------------- #

def show_topper():
    cursor.execute("SELECT name, cgpa FROM students ORDER BY cgpa DESC LIMIT 1")
    result = cursor.fetchone()
    print("🏆 Topper:", result)
    print()


def branch_average():
    cursor.execute("SELECT branch, AVG(cgpa) FROM students GROUP BY branch")
    data = cursor.fetchall()

    print("📊 Average CGPA by Branch:")
    for row in data:
        print(row)
    print()


def skill_filter():
    skill = input("Enter Skill to Search (e.g., python): ")
    query = "SELECT name, skills FROM students WHERE skills LIKE %s"
    cursor.execute(query, ('%' + skill + '%',))
    data = cursor.fetchall()

    print(f"👨‍💻 Students with {skill}:")
    for row in data:
        print(row)
    print()


# ---------------- MENU ---------------- #

while True:
    print("------ STUDENT MANAGEMENT SYSTEM ------")
    print("1. Add Student")
    print("2. View Students")
    print("3. Search Student")
    print("4. Delete Student")
    print("5. Update Student")
    print("6. Show Topper")
    print("7. Branch Average CGPA")
    print("8. Skill Filter")
    print("9. Exit")

    choice = int(input("Enter choice: "))

    if choice == 1:
        add_student()
    elif choice == 2:
        view_students()
    elif choice == 3:
        search_student()
    elif choice == 4:
        delete_student()
    elif choice == 5:
        update_student()
    elif choice == 6:
        show_topper()
    elif choice == 7:
        branch_average()
    elif choice == 8:
        skill_filter()
    elif choice == 9:
        print("Exited...")
        break
    else:
        print("Invalid choice\n")
