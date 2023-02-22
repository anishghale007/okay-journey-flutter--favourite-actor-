import 'dart:io';
import 'package:image_saver/widgets/empty_data.dart';
import 'package:image_saver/widgets/listView_container.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_saver/controller/actor_provider.dart';
import 'package:image_saver/models/actor.dart';
import 'package:image_saver/widgets/listView_separator.dart';

class ActorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer(
            builder: (context, ref, child) {
              final actors = ref.watch(actorDataProvider);
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'My Favourite Actor',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          actors.when(
                            data: (data) {
                              List<Actor> actorList =
                                  data.map((e) => e).toList();
                              return ListView.separated(
                                separatorBuilder: (context, index) =>
                                    ListViewSeparator(),
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: actorList.length,
                                itemBuilder: (context, index) {
                                  final actor = actorList[index];
                                  return ListViewContainer(
                                    actorName: actor.actorName,
                                    actorImage: actor.actorImage,
                                    addedDate: actor.addedDate,
                                  );
                                },
                              );
                            },
                            error: (err, stack) => EmptyData(),
                            loading: () => Center(
                              child: CircularProgressIndicator(
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
