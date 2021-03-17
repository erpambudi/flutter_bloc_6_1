import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc.dart';
import 'number_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //- watch untuk memantau CounterState. kalau ada perubahan dia juga ikut berubah
    CounterState counterState = context.watch<CounterBloc>().state;

    //- select lebih spesifik yaitu untuk memantau value tertentu yang ada di bloc
    //- select membutuhkan 2 tipe yaitu tipe blocnya dan tipe data yang dipantaunya
    int number = context.select<CounterBloc, int>((counterBloc) =>
        (counterBloc.state is CounterValue)
            ? (counterBloc.state as CounterValue).value
            : null);

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Bloc v6.1.1"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //mengecek state dengan BlocBuilder
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return NumberCard("Bloc\nBuilder",
                      (state is CounterValue) ? state.value : null);
                },
              ),
              SizedBox(
                width: 40,
              ),
              //mengecek state dengan Watch
              NumberCard("Watch",
                  (counterState is CounterValue) ? counterState.value : null),
              SizedBox(
                width: 40,
              ),
              //mengecek state dengan select
              NumberCard("Select", number),
              SizedBox(
                width: 40,
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            child: Text(
              "INCREMENT",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              //#read : hanya membaca CounterBloc dan Memanggil event
              context.read<CounterBloc>().add(Increment());
            },
          )
        ],
      ),
    );
  }
}
