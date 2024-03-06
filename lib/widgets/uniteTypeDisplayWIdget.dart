import 'package:flutter/material.dart';

class uniteTypeDisplayWIdget extends StatelessWidget {
  final String unitTypeTitle;
  final String occupancyPercentage;
  final String occupancyAvailableText;
  final String storefrontPrice;
  final String pricePeriodText;

  uniteTypeDisplayWIdget({
    required this.unitTypeTitle,
    required this.occupancyPercentage,
    required this.occupancyAvailableText,
    required this.storefrontPrice,
    required this.pricePeriodText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(unitTypeTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Topbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      // Handle back button action
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unitTypeTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Topbar actions
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle "View on Store" button action
                        },
                        icon: Icon(Icons.remove_red_eye),
                        label: Text("View on Store"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle "Edit Unit Type" button action
                        },
                        child: Text("Edit Unit Type"),
                      ),
                    ],
                  ),
                ],
              ),

              // Occupancy details
              Row(
                children: [
                  // First column
                  Expanded(
                    child: Card(
                      child: Column(
                        children: [
                          Text("Occupancy"),
                          Text(
                            occupancyPercentage,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(occupancyAvailableText),
                        ],
                      ),
                    ),
                  ),
                  // Second column
                  Expanded(
                    child: Card(
                      child: Column(
                        children: [
                          Text("Storefront price"),
                          Text(
                            storefrontPrice,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(pricePeriodText),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Units details
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Units header
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Units",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle "Add Units" button action
                            },
                            child: Text("Add Units"),
                          ),
                        ],
                      ),
                    ),
                    // Units table
                    DataTable(
                      columns: [
                        DataColumn(label: Text("Unit")),
                        DataColumn(label: Text("Occupant")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("")),
                      ],
                      rows: [
                        // Replace the following with actual data
                        DataRow(cells: [
                          DataCell(Text("A08")),
                          DataCell(Text("-")),
                          DataCell(
                            Text(
                              "Unavailable",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: InkWell(
                                    onTap: () {
                                      // Handle "Edit unit" action
                                    },
                                    child: Text("Edit unit"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("A09")),
                          DataCell(Text("-")),
                          DataCell(
                            Text(
                              "Available",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: InkWell(
                                    onTap: () {
                                      // Handle "Edit unit" action
                                    },
                                    child: Text("Edit unit"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),

              // Dynamic pricing rules
              Card(
                child: Column(
                  children: [
                    Text(
                      "Dynamic pricing rules",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("No dynamic occupancy pricing rules currently set up."),
                  ],
                ),
              ),

              // Price history table
              Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price history",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                          value: "Every month", // Replace with actual value
                          onChanged: (newValue) {
                            // Handle dropdown value change
                          },
                          items: ["Every month"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text("Price")),
                        DataColumn(label: Text("")),
                        DataColumn(
                          label: Text(
                            "Created",
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                      rows: [
                        // Replace the following with actual data
                        DataRow(cells: [
                          DataCell(Text("€61,88")),
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Base price",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Billed On Storefront",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Text(
                              "16 Nov 2023",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("€52,00")),
                          DataCell(
                            Text(""),
                          ),
                          DataCell(
                            Text(
                              "26 Oct 2023",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),

              // Unit Type details
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "https://app.stora.co/rails/active_storage/representations/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBZ1BzIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--fc957daa6a6e162e19e947f34a0cd88bbf846780/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RkhKbGMybDZaVjkwYjE5c2FXMXBkRnNIYVFJc0FXa0NMQUU9IiwiZXhwIjpudWxsLCJwdXIiOiJ2YXJpYXRpb24ifX0=--6c22e33b9489d37c6bf04cd643f74f38792c75fd/20-sqft-unit.jpg",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Unit Type details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StackedColumnItem("Nudge", "No"),
                    StackedColumnItem("Description", "5.40 metri cubi"),
                    StackedColumnItem("Width", "1.3 m"),
                    StackedColumnItem("Length", "1.5 m"),
                    StackedColumnItem("Height", "2.7 m"),
                  ],
                ),
              ),

              // Subscription information section
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subscription Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StackedColumnItem("Created", "26 Oct 2023"),
                    StackedColumnItem("Last updated", "05 Mar 2024"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StackedColumnItem extends StatelessWidget {
  final String label;
  final String value;

  StackedColumnItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}