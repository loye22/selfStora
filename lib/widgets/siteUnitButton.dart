import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sitePageButton extends StatefulWidget {
  final String title ;
  final String subtitle ;
  final IconData icon ;
  final VoidCallback callback ;
  final isExpanded  ;


  const sitePageButton({required this.title, required this.subtitle, required this.icon, required this.callback , this.isExpanded = false});

  @override
  State<sitePageButton> createState() => _sitePageButtonState();
}

class _sitePageButtonState extends State<sitePageButton> {
  bool isHover = false ;

  @override
  Widget build(BuildContext context) {
    return this.widget.isExpanded ? Expanded(child:  MouseRegion(
      onExit: (s){
        this.isHover = false ;
        setState(() {});

      },
      onHover: (s){
        this.isHover = true ;
        setState(() {});

      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.callback,

        child: Card(
          child: Container(
            width:MediaQuery.of(context).size.width * 0.55,
            height: this.widget.isExpanded ? MediaQuery.of(context).size.height * .7 : null ,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(this.widget.icon , color: this.isHover ? Colors.orange : null ,) ,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: this.isHover ? Colors.orange : null
                          ),
                        ),
                        Text(
                          widget.subtitle,
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.chevron_right,color: this.isHover ? Colors.orange : null ,) ,
              ],
            ),
          ),
        ),
      ),
    )): MouseRegion(
     onExit: (s){
      this.isHover = false ;
      setState(() {});

    },
      onHover: (s){
        this.isHover = true ;
        setState(() {});

      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.callback,

        child: Card(
          child: Container(
            width:MediaQuery.of(context).size.width * 0.55,
            height: this.widget.isExpanded ? MediaQuery.of(context).size.height * .7 : null ,
            padding: const EdgeInsets.all(16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(this.widget.icon , color: this.isHover ? Colors.orange : null ,) ,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: this.isHover ? Colors.orange : null
                          ),
                        ),
                        Text(
                          widget.subtitle,
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.chevron_right,color: this.isHover ? Colors.orange : null ,) ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
