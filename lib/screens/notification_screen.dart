import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Data notifikasi dummy
  final List<Map<String, dynamic>> notifications = [
    {
      'id': '1',
      'title': 'Pembayaran Iuran RT',
      'message':
          'Pengingat: Iuran RT bulan Agustus belum dibayar. Harap segera lakukan pembayaran.',
      'time': '2 jam yang lalu',
      'type': 'payment',
      'isRead': false,
      'icon': Icons.payment,
      'color': Colors.orange,
    },
    {
      'id': '2',
      'title': 'Rapat RT Mendatang',
      'message':
          'Rapat RT akan dilaksanakan pada hari Minggu, 27 Agustus 2025 pukul 19:00 WIB.',
      'time': '5 jam yang lalu',
      'type': 'meeting',
      'isRead': true,
      'icon': Icons.meeting_room,
      'color': Colors.blue,
    },
    {
      'id': '3',
      'title': 'Laporan Diterima',
      'message':
          'Laporan Anda tentang lampu jalan rusuk telah diterima dan sedang ditindaklanjuti.',
      'time': '1 hari yang lalu',
      'type': 'report',
      'isRead': true,
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'id': '4',
      'title': 'Kegiatan Gotong Royong',
      'message':
          'Kegiatan gotong royong minggu depan. Mari berpartisipasi untuk lingkungan yang bersih!',
      'time': '2 hari yang lalu',
      'type': 'event',
      'isRead': false,
      'icon': Icons.groups,
      'color': Colors.purple,
    },
    {
      'id': '5',
      'title': 'Pengumuman Penting',
      'message':
          'Akan ada pemadaman listrik bergilir pada tanggal 30 Agustus 2025 pukul 09:00-15:00.',
      'time': '3 hari yang lalu',
      'type': 'announcement',
      'isRead': true,
      'icon': Icons.campaign,
      'color': Colors.red,
    },
    {
      'id': '6',
      'title': 'Pengumuman Penting',
      'message':
          'Akan ada pemadaman listrik bergilir pada tanggal 05 Agustus 2025 pukul 09:00-15:00.',
      'time': '3 hari yang lalu',
      'type': 'announcement',
      'isRead': true,
      'icon': Icons.campaign,
      'color': Colors.red,
    },
    {
      'id': '7',
      'title': 'Pengumuman Penting',
      'message':
          'Lomba Kemerdekaan 17 Agustus 2025 segera di selenggarakan oleh 3 RT loh!🤩',
      'time': '3 hari yang lalu',
      'type': 'announcement',
      'isRead': true,
      'icon': Icons.campaign,
      'color': Colors.red,
    },
    {
      'id': '8',
      'title': 'Selamat Datang!',
      'message':
          'Selamat datang di aplikasi RT digital! Nikmati berbagai layanan untuk warga.',
      'time': '1 minggu yang lalu',
      'type': 'welcome',
      'isRead': true,
      'icon': Icons.celebration,
      'color': Colors.indigo,
    },
  ];

  int get unreadCount => notifications.where((n) => !n['isRead']).length;

  void _markAsRead(String notificationId) {
    setState(() {
      final index = notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        notifications[index]['isRead'] = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void _deleteNotification(String notificationId) {
    setState(() {
      notifications.removeWhere((n) => n['id'] == notificationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Tandai Semua',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                if (unreadCount > 0)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: Colors.blue[600],
                          size: 20,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '$unreadCount notifikasi belum dibaca',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8.0),
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return _buildNotificationItem(notification);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80.0, color: Colors.grey[400]),
          const SizedBox(height: 16.0),
          Text(
            'Tidak ada notifikasi',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Notifikasi akan muncul di sini',
            style: TextStyle(fontSize: 14.0, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final bool isUnread = !notification['isRead'];

    return Dismissible(
      key: Key(notification['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 24.0),
      ),
      onDismissed: (direction) {
        _deleteNotification(notification['id']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Notifikasi dihapus'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => _markAsRead(notification['id']),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isUnread ? Colors.blue[50] : Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: isUnread ? Colors.blue[200]! : Colors.grey[200]!,
              width: isUnread ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8.0,
                offset: const Offset(0, 2.0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: notification['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  notification['icon'],
                  color: notification['color'],
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 12.0),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: isUnread
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      notification['message'],
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      notification['time'],
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
