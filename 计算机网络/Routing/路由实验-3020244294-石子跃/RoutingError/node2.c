#include <stdio.h>

extern struct rtpkt {
	int sourceid;       /* id of sending router sending this pkt */
	int destid;         /* id of router to which pkt being sent
                         (must be an immediate neighbor) */
	int mincost[4];    /* min cost to node 0 ... 3 */
};

extern int TRACE;
extern int YES;
extern int NO;

struct distance_table {
	int costs[4][4];
} dt2;


/* students to write the following two routines, and maybe some others */

int connectcosts2[4] = { 3,  1,  0, 2 };
#define INFINITY 999
#define MAX_NODES 4

void rtinit2() {
	int NOW_NODE = 2;
	//�� INFINITY ��ʼ��
	int i;
	int j;
	for ( i = 0; i < MAX_NODES; i++) {
		for (j = 0; j < MAX_NODES; j++) {
			dt2.costs[i][j] = INFINITY;
			if (i == j)
				dt2.costs[i][j] = 0;
		}
	}
	for(i=0; i<MAX_NODES; i++) {
		dt2.costs[2][i] = connectcosts2[i];
	}
	//�������ھӽ�㷢�;���?����
	for ( i = 0; i < MAX_NODES; i++) {
		//������������(i=nodei)�Լ����ɴ���(���� INFINAITY)
		if (i != 2 && dt2.costs[2][i] != INFINITY) {
			struct rtpkt node2_pkt;
			creatertpkt(&node2_pkt, 2, i, dt2.costs[2]);
			tolayer2(node2_pkt);
		}
	}
	printf("	��ʼ��node2==rtinit2\n");
	printdt22(&dt2);
}


void rtupdate2(rcvdpkt)
struct rtpkt *rcvdpkt;

{
	int i;
	//���жϽ������ݰ�rcvpkt->destid�Ƿ�Ϊ��ȷnode
	if (rcvdpkt->destid == 2) {
		//ʹ�ñ�־λ���
		int flag = 0;
		//���ݽ��յ�·����Ϣ�������Լ���·�ɱ�
		for ( i = 0; i < MAX_NODES; i++) {
			dt2.costs[rcvdpkt->sourceid][i] = rcvdpkt->mincost[i];
		}
		//���¼����������
		for (i=0; i<MAX_NODES; i++) {
			int temp = 0;
			temp = dt2.costs[2][rcvdpkt->sourceid]+rcvdpkt->mincost[i];
			//��֤���ֵ��ΪMAX
			if (temp > INFINITY) temp = INFINITY;
			if(temp<dt2.costs[2][i]) {
				dt2.costs[2][i]=temp;
				flag = 1;
			}
		}
		if(flag) {
			for (i = 0; i < MAX_NODES; i++) {
				//������������(i=nodei)�Լ����ɴ���(���� INFINAITY)
				if (i != 2 && dt2.costs[2][i] != INFINITY) {
					struct rtpkt node2_pkt;
					creatertpkt(&node2_pkt, 2, i, dt2.costs[2]);
					tolayer2(node2_pkt);
				}
			}
			printf("	����node2==rtupdate2\n");
			printdt22(&dt2);
		}
		else{
			printf("	δ�ı�node2==rtupdate2\n");
			printdt22(&dt2);
		}		 
	}
}


printdt2(dtptr)
struct distance_table *dtptr;

{
	printf("                via     \n");
	printf("   D2 |    0     1    3 \n");
	printf("  ----|-----------------\n");
	printf("     0|  %3d   %3d   %3d\n",dtptr->costs[0][0],
	       dtptr->costs[0][1],dtptr->costs[0][3]);
	printf("dest 1|  %3d   %3d   %3d\n",dtptr->costs[1][0],
	       dtptr->costs[1][1],dtptr->costs[1][3]);
	printf("     3|  %3d   %3d   %3d\n",dtptr->costs[3][0],
	       dtptr->costs[3][1],dtptr->costs[3][3]);
}
printdt22(dtptr)
struct distance_table *dtptr;

{
	printf("             dest   \n");
	printf("   D2 |    0    1     2    3 \n");
	printf("  ----|----------------------\n");
	printf("     0|  %3d   %3d   %3d   %3d\n",dtptr->costs[0][0],dtptr->costs[0][1],
	       dtptr->costs[0][2],dtptr->costs[0][3]);
	printf("     1|  %3d   %3d   %3d   %3d\n",dtptr->costs[1][0],dtptr->costs[1][1],
	       dtptr->costs[1][2],dtptr->costs[1][3]);
	printf("var  2|  %3d   %3d   %3d   %3d\n",dtptr->costs[2][0],dtptr->costs[2][1],
	       dtptr->costs[2][2],dtptr->costs[2][3]);
	printf("     3|  %3d   %3d   %3d   %3d\n",dtptr->costs[3][0],dtptr->costs[3][1],
	       dtptr->costs[3][2],dtptr->costs[3][3]);
	       printf("\n"); 
}





