import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/address_model.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key, required this.onSubmit});
  final ValueChanged<Address> onSubmit;

  @override
  State<AddressForm> createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'John Doe');
  final _streetController = TextEditingController(text: '123 Main Street');
  final _cityController = TextEditingController(text: 'San Francisco');
  final _stateController = TextEditingController(text: 'CA');
  final _zipController = TextEditingController(text: '94102');
  final _countryController = TextEditingController(text: 'United States');

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  bool validate() => _formKey.currentState?.validate() ?? false;

  Address getAddress() => Address(
        fullName: _nameController.text.trim(),
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        zipCode: _zipController.text.trim(),
        country: _countryController.text.trim(),
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping Address',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          const SizedBox(height: AppConstants.spacingMd),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _streetController,
            decoration: const InputDecoration(labelText: 'Street Address'),
            validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(labelText: 'State'),
                  validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _zipController,
                  decoration: const InputDecoration(labelText: 'Zip Code'),
                  keyboardType: TextInputType.number,
                  validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                  validator: (v) => (v?.isEmpty ?? true) ? 'Required' : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
