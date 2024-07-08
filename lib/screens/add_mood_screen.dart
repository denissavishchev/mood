import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:provider/provider.dart';

class AddMoodScreen extends StatelessWidget {
  const AddMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 40,),
                TextField(
                  controller: data.moodTextController,
                  decoration: InputDecoration(
                      hintText: 'mood',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
                const SizedBox(height: 40,),
                TextField(
                  controller: data.actionTextController,
                  decoration: InputDecoration(
                      hintText: 'action',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
                const SizedBox(height: 40,),
                TextField(
                  controller: data.personTextController,
                  decoration: InputDecoration(
                      hintText: 'person',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
                const SizedBox(height: 40,),
                TextField(
                  controller: data.placeTextController,
                  decoration: InputDecoration(
                      hintText: 'place',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
                const SizedBox(height: 40,),
                TextField(
                  controller: data.ratingTextController,
                  decoration: InputDecoration(
                      hintText: 'rating',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
                const SizedBox(height: 40,),
                TextField(
                  controller: data.descriptionTextController,
                  decoration: InputDecoration(
                      hintText: 'description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
                const SizedBox(height: 40,),
                GestureDetector(
                  onTap: () => data.pickAnImage(),
                  child: Container(
                    width: 100,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    child: data.fileName == ''
                        ? const Icon(Icons.camera_alt)
                        : Image.file(File(data.file!.path), fit: BoxFit.cover,),
                  ),
                ),
                const SizedBox(height: 40,),
                ElevatedButton(
                    onPressed: () => data.insertMood(context),
                    child: const Text('Add'))
              ],
            ),
          );
        }
    );
  }
}
