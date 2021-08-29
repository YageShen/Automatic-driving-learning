#include <iostream>
#include <vector>
#include <queue>

using namespace std;

#define INF_ 99999
#define PII pair<int, int>

class DijGraph {
public:
	DijGraph(int vCount) : vCount_(vCount) {
		adj_ = vector<vector<Edge>>(vCount);
	}
	void addEdge(int s, int e, int w) {
		if(s < vCount_ && s >= 0 && e < vCount_ && e >= 0) {
//			Edge temp(s, e, w);
//			adj_[s].emplace_back(temp);
			adj_[s].emplace_back(s, e, w);
		}
	}
	int dijkstra(int s, int e) {
		vector<int> parent(vCount_);
		vector<Vertex> vertexes(vCount_);
		for(int i = 0; i < vCount_; ++i) {
			vertexes[i].id_ = i;
			vertexes[i].dist_ = INF_;
		}

		struct cmp {
			bool operator() (const Vertex& v1, const Vertex& v2) {
				return v1.dist_ > v2.dist_;
			}
		};
		priority_queue<Vertex, vector<Vertex>, cmp> queue;
		vector<bool> vis(vCount_, false);

		vertexes[s].dist_ = 0;
		queue.push(vertexes[s]);
		while (!queue.empty()) {
			Vertex minVertex = queue.top();
			queue.pop();
			if(minVertex.id_ == e) break;
			if(vis[minVertex.id_] == true) continue;
			vis[minVertex.id_] = true;
			for(int i = 0; i < adj_[minVertex.id_].size(); ++i) {
				Edge cur_edge = adj_[minVertex.id_].at(i);
				int nex_vid = cur_edge.eid_;
				if(!vis[nex_vid]) {
					if(minVertex.dist_ + cur_edge.w_ < vertexes[nex_vid].dist_) {
						vertexes[nex_vid].dist_ = minVertex.dist_ + cur_edge.w_;
						parent[nex_vid] = minVertex.id_;
						queue.push(vertexes[nex_vid]);
					}
				}
			}
		}

		printRoute(s, e, parent);
		cout << endl;
		return vertexes[e].dist_;
}
private:
	struct Edge {
		int sid_;
		int eid_;
		int w_;
		Edge() = default;
		Edge(int s, int e, int w) : sid_(s), eid_(e), w_(w) {}
	};
	struct Vertex {
		int id_;
		int dist_;
		Vertex() = default;
		Vertex(int id, int dist) : id_(id), dist_(dist) {}
	};
	vector<vector<Edge>> adj_; // 邻接表
	int vCount_;

	void printRoute(int s, int e, const vector<int>& parent) {
		if(s == e) {
			cout << s;
			return;
		}
		printRoute(s, parent[e], parent);
		cout << "->" << e;
	}
};

class Solution {
public:
    int minCost(vector<vector<int>>& A) {
        rows = A.size();
        cols = A[0].size();

		DijGraph g{rows * cols};
		for(int i = 0; i < rows; ++i) {
			for(int j = 0; j < cols; ++j) {
				if(A[i][j] != 2) {
					int cur_id = sub2ind(i, j);
					int cur_cost = cost[A[i][j]];
					if(i >= 1) {
						g.addEdge(sub2ind(i-1, j), cur_id, cur_cost);
					}
					if(i < rows - 1) {
						g.addEdge(sub2ind(i+1, j), cur_id, cur_cost);
					}
					if(j >= 1) {
						g.addEdge(sub2ind(i, j-1), cur_id, cur_cost);
					}
					if(j < cols - 1) {
						g.addEdge(sub2ind(i, j+1), cur_id, cur_cost);
					}
				}
			}
		}
		int min_cost = g.dijkstra(0, rows * cols - 1);

        return min_cost;
    }
private:
	int cost[3] = {2, 1, INF_};
	int rows, cols;
    int sub2ind(int i, int j) {
    	if(j >= cols || i >= rows)
			return -1;
        return i * cols + j;
    }
    PII ind2sub(int ind) {
        PII ret;
        ret.first = ind / cols;
        ret.second = ind & cols;
        if(ret.first >= rows)
			return PII(-1, -1);
        return ret;
    }
};

int main() {
    Solution sol;
//    vector<int>r1 = {1,1,1,1,0};
//    vector<int>r2 = {0,1,2,1,0};
//    vector<int>r3 = {1,1,2,1,1};
//    vector<int>r4 = {0,2,0,0,1};
    vector<int>r1 = {1,1,0,1,0};
    vector<int>r2 = {0,1,2,1,1};
    vector<int>r3 = {1,1,1,1,0};
    vector<int>r4 = {1,1,0,1,1};
    vector<vector<int>> A;
    A.push_back(r1); A.push_back(r2); A.push_back(r3); A.push_back(r4);
    cout << sol.minCost(A) << endl;
    return 0;
}
