import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_saver/controller/actor_provider.dart';
import 'package:image_saver/controller/image_provider.dart';
import 'package:image_saver/widgets/custom_button.dart';
import 'package:image_saver/widgets/custom_formField.dart';
import 'package:image_saver/widgets/form_header.dart';
import 'package:image_saver/widgets/image_container.dart';

class FormScreen extends StatelessWidget {
  final actorNameController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer(
            builder: (context, ref, child) {
              final image = ref.watch(imageProvider).image;
              return Form(
                key: _form,
                child: Column(
                  children: [
                    FormHeader(header: 'Save Actor Form'),
                    CustomFormField(
                      controller: actorNameController,
                      labelText: 'Favourite Actor\'s name',
                      hintText: 'Enter the actor\'s name..',
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Actor name is required";
                        }
                        if (val!.length > 30) {
                          return "The maximum length is 30";
                        }
                      },
                    ),
                    ImageContainer(
                        onPress: () async {
                          ref.read(imageProvider).getGalleryImage();
                        },
                        content: image == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      'assets/images/profile_picture.png'),
                                  Text(
                                    'Upload your actor picture',
                                    style: TextStyle(
                                      color: Color(0xFFADADAD),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'maximum size: 2MB',
                                    style: TextStyle(
                                      color: Color(0xFFADADAD),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : Image.file(File(image.path))),
                    CustomButton(
                      buttonText: 'Submit',
                      onPress: () async {
                        _form.currentState!.save();
                        if (_form.currentState!.validate()) {
                          if (image == null) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Image Required"),
                                content: const Text(
                                    "Please upload the actor image."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Ok"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            final response = await ref
                                .read(actorProvider)
                                .addActor(
                                  actorName: actorNameController.text.trim(),
                                  imagePath: image!.path.toString(),
                                );
                            final refresh =
                                await ref.refresh(actorDataProvider);
                            if (response == 'Success') {
                              print(response);
                              actorNameController.clear();
                              ref.read(imageProvider).removeImage();
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Success !!"),
                                  content: const Text(
                                      "Your data has been saved. Go to another page to view your saved data."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text("Ok"),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              print(response);
                              print('Error');
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
