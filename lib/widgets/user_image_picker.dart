
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar( // shows preview of the image
         radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: ...,
        ),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.image),
            label: Text(
              'Add image',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
        ),
      ],
    );
  }
}
