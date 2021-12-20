from pymongo import MongoClient


client = MongoClient(
    "mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb")
db = client['assn12']
collection = db['customers']


def create():                # insert document
    global collection
    id = input("Enter id: ")
    name = input("Enter name: ")
    new_customer = {
        "id": id,
        "name": name,
    }
    collection.insert_one(new_customer)


def read():                  # get all records
    global collection
    response = collection.find()
    for record in response:
        print(record)


def update():                # update a record
    global collection
    id = input("Enter id: ")
    name = input("Enter name: ")
    prev_record = {'id': id}
    new_record = {
        "id": id,
        "name": name,
    }
    response = collection.update_one(prev_record, {'$set': new_record})


def delete():               # delete the record
    global collection
    id = input("Enter id: ")
    record = {'id': id}
    response = collection.delete_one(record)


while True:
    option = int(input(
        "Choose your operation?\n1) Create \n2) Read \n3) Update \n4) Delete \n5) Exit\n"))
    if option == 1:
        create()
        print("Insert operation successful.\n")
    if option == 2:
        read()
        print("Read operation successful.\n")
    if option == 3:
        update()
        print("Update operation successful.\n")
    if option == 4:
        delete()
        print("Delete soperation successful.\n")
    if option == 5:
        break
client.close()
