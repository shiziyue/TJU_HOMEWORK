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
} dt3;

/* students to write the following two routines, and maybe some others */

int connectcosts3[4] = { 7,  999,  2, 0 };
#define INFINITY 999
#define MAX_NODES 4

void rtinit3() {
	int NOW_NODE =3;
	//�� INFINITY ��ʼ��
	int i;
	int j;
	for ( i = 0; i < MAX_NODES; i++) {
		for (j = 0; j < MAX_NODES; j++) {
			dt3.costs[i][j] = INFINITY;
			if (i == j)
				dt3.costs[i][j] = 0;
		}
	}
	for(i=0; i<MAX_NODES; i++) {
		dt3.costs[NOW_NODE][i] = connectcosts3[i];
	}
	//�������ھӽ�㷢�;���?����
	for ( i = 0; i < MAX_NODES; i++) {
		//������������(i=nodei)�Լ����ɴ���(���� INFINAITY)
		if (i != NOW_NODE && dt3.costs[NOW_NODE][i] != INFINITY) {
			struct rtpkt node3_pkt;
			creatertpkt(&node3_pkt, 3, i, dt3.costs[NOW_NODE]);
			tolayer2(node3_pkt);
		}
	}
	printf("	��ʼ��node3==rtinit3\n");
	printdt33(&dt3);
}


void rtupdate3(rcvdpkt)
struct rtpkt *rcvdpkt;

{
	int i;
	//���жϽ������ݰ�rcvpkt->destid�Ƿ�Ϊ��ȷnode
	if (rcvdpkt->destid == 3) {
		//ʹ�ñ�־λ���
		int flag = 0;
		//���ݽ��յ�·����Ϣ�������Լ���·�ɱ�
		for ( i = 0; i < MAX_NODES; i++) {
			dt3.costs[rcvdpkt->sourceid][i] = rcvdpkt->mincost[i];
		}
		//���¼����������
		for (i=0; i<MAX_NODES; i++) {
			int temp = 0;
			temp = dt3.costs[3][rcvdpkt->sourceid]+rcvdpkt->mincost[i];
			//��֤���ֵ��ΪMAX
			if (temp > INFINITY) temp = INFINITY;
			if(temp<dt3.costs[3][i]) {
				dt3.costs[3][i]=temp;
				flag = 1;
			}
		}
		if(flag) {
			for (i = 0; i < MAX_NODES; i++) {
				//������������(i=nodei)�Լ����ɴ���(���� INFINAITY)
				if (i != 3 && dt3.costs[3][i] != INFINITY) {
					struct rtpkt node3_pkt;
					creatertpkt(&node3_pkt, 3, i, dt3.costs[3]);
					tolayer2(node3_pkt);
				}
			}
			printf("	����node3==rtupdate3\n");
			printdt33(&dt3);
		}
		else{
			printf("	δ�ı�node3==rtupdate3\n");
			printdt33(&dt3);
		} 
	}
}


printdt3(dtptr)
struct distance_table *dtptr;

{
	printf("             via     \n");
	printf("   D3 |    0     2 \n");
	printf("  ----|-----------\n");
	printf("     0|  %3d   %3d\n",dtptr->costs[0][0], dtptr->costs[0][2]);
	printf("dest 1|  %3d   %3d\n",dtptr->costs[1][0], dtptr->costs[1][2]);
	printf("     2|  %3d   %3d\n",dtptr->costs[2][0], dtptr->costs[2][2]);

}
printdt33(dtptr)
struct distance_table *dtptr;

{
	printf("             dest   \n");
	printf("   D3 |    0    1     2    3 \n");
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





