import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:share/share.dart';
import 'methods.dart';
import 'add_blank_event.dart';


class EditDetailJobsPage extends StatefulWidget{
  //final DocumentSnapshot post;

  EditDetailJobsPage({this.CompanyName, this.CompanyDes, this.CompanyLogo, this.PostDate, this.PostTime, this.JobSalary, this.CompanyEmail, this.JobID, this.JobURL, this.JobName, this.index});
  final String CompanyName;
  final String CompanyDes;
  final String CompanyLogo;
  final String PostDate;
  final String PostTime;
  final String CompanyEmail;
  final String JobID;
  final String JobURL;
  final String JobName;
  final String JobSalary;
  final index;

  State<StatefulWidget> createState(){
    return EditDetailJobsPageState();
  }
}

class EditDetailJobsPageState extends State<EditDetailJobsPage> {

  final TextEditingController _textEditingController= new TextEditingController();
  final TextEditingController _textEditingController1= new TextEditingController();
  final TextEditingController _textEditingController2= new TextEditingController();
  final TextEditingController _textEditingController3= new TextEditingController();
  final TextEditingController _textEditingController4= new TextEditingController();
  final TextEditingController _textEditingController5= new TextEditingController();
  final TextEditingController _textEditingController6= new TextEditingController();
  final TextEditingController _textEditingController7= new TextEditingController();

  bool _validateName= false;
  bool _validateDes= false;
  bool _validateLoc= false;
  bool _validateHostDept= false;
  bool _validateDuration= false;
  bool _validateID= false;
  bool _validateDate= false;
  bool _validateImageURL= false;

  String newName= "";
  String newDes="";
  String newCompany= "";
  String newID= "";
  String _dateText= "";
  String newLogo= "";
  String newEmail= "";
  String newImage= "";
  String newTime="";
  String newSalary="";
  String newJob= "";

  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _dueDate= DateTime.now();

  Future<Null> _selectDueDate(BuildContext context) async{
    final picked = await showDatePicker(context: context,
        initialDate: DateTime(2019), firstDate: DateTime(2019), lastDate: DateTime(2080));

    if (picked != null){
      setState(() {
        _dueDate= picked;
        _dateText = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async{
    final TimeOfDay picked_time = await showTimePicker(context: context, initialTime: new TimeOfDay.now());

    if (picked_time != null){
      print("picked");
      setState(() {
        _timeOfDay= picked_time;
        newTime = "${picked_time.hour}: ${picked_time.minute}";
      });
    }
  }

  @override
  void initState(){
    super.initState();
    _dateText= "${_dueDate.day}-${_dueDate.month}-${_dueDate.year}";
    newTime="${_timeOfDay.hour}:${_timeOfDay.minute}";
  }




  void _editData(){
    Firestore.instance.runTransaction((Transaction transaction) async{
      DocumentSnapshot snapshot= await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {

        "company": newCompany,
        "companyLogo": "https://images.idgesg.net/images/article/2018/10/ai_artificial-intelligence_circuit-board_circuitry_mother-board_nodes_computer-chips-100777423-large.jpg",
        "name": newJob,
        "email": newEmail,
        "imageURL": "https://images.idgesg.net/images/article/2018/10/ai_artificial-intelligence_circuit-board_circuitry_mother-board_nodes_computer-chips-100777423-large.jpg",
        "id": newID,
        "description": newDes,
        "postDate": _dateText,
        "time": newTime,
        "salary": newSalary
      }
      );
    }
    );
    Navigator.pop(context);
  }


  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.edit, size: 30,),
                        SizedBox(width:8.0),
                        Text("Edit Job Post", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController1,
                            keyboardType: TextInputType.number,
                            onChanged: (String str){
                              setState(() {
                                newID= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.local_offer),
                              labelText: "Compant ID",
                              hintText: widget.JobID,
                              errorText: _validateID? "Event ID cannot be empty and itmust be an integer!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            onChanged: (String str){
                              setState(() {
                                if (str.isEmpty){
                                  _validateName= true;
                                }else{
                                  newCompany= str;
                                }

                              });
                            },
                            decoration: InputDecoration(
                              hintText: widget.CompanyName,
                              prefixIcon: Icon(Icons.home),
                              labelText: "Company Name",
                              errorText: _validateName? "Event name cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 13.0,),
                        Icon(Icons.access_time, color: Colors.black54,),
                        Expanded(
                          child: FlatButton(
                            onPressed: (){
                              _selectTime(context);
                            },
                            child: Text(newTime),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 13.0,),
                        Icon(Icons.event, color: Colors.black54,),
                        Expanded(
                          child: FlatButton(
                            onPressed: (){
                              _selectDueDate(context);
                            },
                            child: Text(_dateText),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController3,
                            onChanged: (String str){
                              setState(() {
                                newLogo= str;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: widget.CompanyLogo,
                              prefixIcon: Icon(Icons.photo_album),
                              labelText: "Company Logo",
                              errorText: _validateDuration? "Event duration cannot be empty and itmust be an integer!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController6,
                            onChanged: (String str){
                              setState(() {
                                if (str.isEmpty== true){

                                }
                                newJob= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: widget.JobName,
                              labelText: "Job Name",
                              errorText: _validateLoc? "Event location cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController4,
                            onChanged: (String str){
                              setState(() {
                                newDes= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.subject),
                              hintText: widget.CompanyDes,
                              labelText: "Job Description",
                              errorText: _validateDes? "Event description cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController5,
                            onChanged: (String str){
                              setState(() {
                                if (str.isEmpty== true){

                                }
                                newEmail= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: widget.CompanyEmail,
                              labelText: "Company Email",
                              errorText: _validateHostDept? "Host Department cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(

                            //controller: _textEditingController7,
                            onChanged: (String str){
                              setState(() {
                                newImage= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.image),
                              hintText: widget.JobURL,
                              labelText: "Job Image",
                              errorText: _validateImageURL? "Event image cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            //controller: _textEditingController7,
                            onChanged: (String str){
                              setState(() {
                                newSalary= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_money),
                              hintText: widget.JobSalary,
                              labelText: "Job Salary",
                              errorText: _validateImageURL? "Event image cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: (){
                            setState(() {
                              /*
                              if (_textEditingController1.text.isEmpty){
                                _validateID=true;
                              }else if (_textEditingController.text.isEmpty){
                                _validateName=true;
                              }else if (_textEditingController2.text.isEmpty){
                                _validateDate=true;
                              }else if (_textEditingController3.text.isEmpty){
                                _validateDuration=true;
                              }else if (_textEditingController4.text.isEmpty){
                                _validateDes=true;
                              }else if (_textEditingController5.text.isEmpty){
                                _validateHostDept=true;
                              }else if (_textEditingController6.text.isEmpty){
                                _validateLoc=true;
                              }else if (_textEditingController7.text.isEmpty){
                                _validateImageURL=true;
                              }else{
                                _addData();
                              }
                              */
                              _editData();

                            });
                            //_addData();
                          },
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


/*
hild: ListTile(
          leading: Icon(Icons.title),
          title: Text(widget.post.data["name"]),
          subtitle: Text(widget.post.data["description"]),
 */