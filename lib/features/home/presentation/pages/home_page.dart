import 'package:complaint_app/config/extensions/navigator.dart';
import 'package:complaint_app/core/connection/network_info.dart';
import 'package:complaint_app/core/databases/api/dio_consumer.dart';
import 'package:complaint_app/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:complaint_app/features/complaints/data/repositories/complaints_repository_impl.dart';
import 'package:complaint_app/features/complaints/domain/usecases/add_complaints.dart';
import 'package:complaint_app/features/complaints/presentation/bloc/add_complaint_bloc.dart';
import 'package:complaint_app/features/complaints/presentation/pages/add_complaints_page.dart';
import 'package:complaint_app/features/home/presentation/widgets/home_header.dart';
import 'package:complaint_app/features/home/presentation/widgets/recent_complaint_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildAddComplaintPage() {
    final apiConsumer = DioConsumer(dio: Dio());
    final remoteDataSource = ComplaintsRemoteDataSource(api: apiConsumer);
    final repository = ComplaintRepositoryImpl(
      remoteDataSource: remoteDataSource,
      networkInfo: NetworkInfoImpl(),
    );
    final addComplaintUseCase = AddComplaint(repository: repository);

    return BlocProvider(
      create: (_) => AddComplaintBloc(addComplaintUseCase: addComplaintUseCase),
      child: const AddComplaintsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Complaint> dummyComplaints = [
      Complaint(
        type: 'مالية',
        entity: 'وزارة المالية',
        date: DateTime(2023, 11, 15),
        status: ComplaintStatus.completed,
      ),
      Complaint(
        type: 'خدمات عامة',
        entity: 'مؤسسة المياه',
        date: DateTime(2023, 11, 10),
        status: ComplaintStatus.inReview,
      ),
      Complaint(
        type: 'بنية تحتية',
        entity: 'مديرية الطرق',
        date: DateTime(2023, 11, 01),
        status: ComplaintStatus.rejected,
      ),
      Complaint(
        type: 'إدارية',
        entity: 'وزارة التنمية',
        date: DateTime(2023, 10, 25),
        status: ComplaintStatus.newComplaint,
      ),
      Complaint(
        type: 'خدمات عامة',
        entity: 'هيئة النقل',
        date: DateTime(2023, 09, 20),
        status: ComplaintStatus.completed,
      ),
    ];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 240, 240),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(),
              const SizedBox(height: 24),
              Text('آخر الشكاوى المضافة', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 2.h),
                  itemCount: dummyComplaints.length,
                  itemBuilder: (context, index) {
                    return RecentComplaintTile(
                      complaint: dummyComplaints[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushPage(_buildAddComplaintPage());
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
