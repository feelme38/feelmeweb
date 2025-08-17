import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:flutter/material.dart';

class ChecklistsCustomerList extends StatelessWidget {
  final List<CustomerResponse> customers;
  final String? selectedCustomerId;
  final Function(String) onCustomerSelected;

  const ChecklistsCustomerList({
    super.key,
    required this.customers,
    required this.selectedCustomerId,
    required this.onCustomerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        final customer = customers[index];
        final isSelectedCustomer = selectedCustomerId == customer.id;

        return ListTile(
          title: Text(customer.name ?? ''),
          tileColor: isSelectedCustomer ? Colors.blue[100] : Colors.transparent,
          onTap: () {
            if (customer.id != null) {
              onCustomerSelected(customer.id!);
            }
          },
        );
      },
    );
  }
}
