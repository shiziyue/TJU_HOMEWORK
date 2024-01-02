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
		dt3.costs[i][3] = connectcosts3[i];
	}
	//向所有邻居结点发送距离?量表
	for ( i = 0; i < MAX_NODES; i++) {
		//即除了自身结点(i=nodei)以及不可达结点(距离 INFINAITY)
		if (i != 3 && dt3.costs[i][3] != INFINITY) {
			struct rtpkt node3_pkt;
			creatertpkt(&node3_pkt, 3, i, connectcosts3);
			tolayer2(node3_pkt);
		}
	}
	printf("	初始化node3==rtinit3\n");
	printdt3(&dt3);
}


void rtupdate3(rcvdpkt)
struct rtpkt *rcvdpkt;

{
	int i;
	//先判断接收数据包rcvpkt->destid是否为正确node
	if (rcvdpkt->destid == 3) {
		//使用标志位标记
		int flag = 0;
		//重新计算距离向量
		for (i=0; i<MAX_NODES; i++) {
			int temp = 0;
			temp = dt3.costs[rcvdpkt->sourceid][3]+rcvdpkt->mincost[i];
			//保证最大值都为MAX
			if (temp > INFINITY) temp = INFINITY;
			if(temp!=dt3.costs[i][rcvdpkt->sourceid]) {
				dt3.costs[i][rcvdpkt->sourceid]=temp;
				if(temp<connectcosts3[i]) {
					connectcosts3[i]=temp;
					flag = 1;
				}
			}
		}
		if(flag) {
			for ( i = 0; i < MAX_NODES; i++) {
				//即除了自身结点(i=nodei)以及不可达结点(距离 INFINAITY)
				if (i != 3 && dt3.costs[i][3] != INFINITY) {
					struct rtpkt node3_pkt;
					creatertpkt(&node3_pkt, 3, i, connectcosts3);
					tolayer2(node3_pkt);
				}
			}
			printf("	更新node3==rtupdate3\n");
			printdt3(&dt3);
		} else {
			printf("	未改变node3==rtupdate3\n");
			printdt3(&dt3);
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






