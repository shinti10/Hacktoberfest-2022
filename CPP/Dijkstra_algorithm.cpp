// C++ program for Dijkstra's single source shortest path algorithm. The program is for adjacency matrix representation of the graph
#include <bits/stdc++.h>
using namespace std;
vector<vector<int>> adj;
// A utility function to find the vertex with minimum distance value, from the set of vertices not yet included in shortest path tree
int minDistance(int dist[], bool sptSet[])
{

	// Initialize min value
	int min = INT_MAX, min_index;

	for (int v = 0; v < V; v++)
		if (sptSet[v] == false && dist[v] <= min)
			min = dist[v], min_index = v;

	return min_index;
}

// A utility function to print the constructed distance array
void printSolution(int dist[])
{
	cout << "Vertex \t Distance from Source" << endl;
	for (int i = 0; i < V; i++)
		cout << i << " \t\t\t\t" << dist[i] << endl;
}

// Function that implements Dijkstra's single source shortest path algorithm for a graph represented using adjacency matrix representation
void dijkstra(int src)
{
  int V = adj.size();
	int dist[V]; // The output array. dist[i] will hold the shortest
	// distance from src to i

	bool sptSet[V]; // sptSet[i] will be true if vertex i is included in shortest path tree or shortest distance from src to i is finalized

	// Initialize all distances as INFINITE and stpSet[] as false
	for (int i = 0; i < V; i++)
		dist[i] = INT_MAX, sptSet[i] = false;

	// Distance of source vertex from itself is always 0
	dist[src] = 0;

	// Find shortest path for all vertices
	for (int count = 0; count < V - 1; count++) {
		// Pick the minimum distance vertex from the set of vertices not yet processed. u is always equal to src in the first iteration.
		int u = minDistance(dist, sptSet);

		// Mark the picked vertex as processed
		sptSet[u] = true;

		// Update dist value of the adjacent vertices of the picked vertex.
		for (int v = 0; v < V; v++)

			// Update dist[v] only if is not in sptSet, there is an edge from u to v, and total weight of path from src to v through u is smaller than current value of dist[v]
			if (!sptSet[v] && adj[u][v]
				&& dist[u] != INT_MAX
				&& dist[u] + adj[u][v] < dist[v])
				dist[v] = dist[u] + adj[u][v];
	}

	// print the constructed distance array
	printSolution(dist);
}
void make_graph(vector<vector<int>> &edges, int n){
  for(auto x: edges){
    adj[x[0]][x[1]] = 1;
    adj[x[1]][x[0]] = 1;
  }
}
// driver's code
int main()
{
	/* Let us create the example graph discussed above */
	int e; cin>>e;
  int n; cin>>n;
  adj.resize(n, vector<int>(n, 0));
  
  vector<vector<int>> edges;
  for(int i=0; i< e; i++){
    int x, y; cin>>x>>y;
    edges.push_back({x,y});
  }
  make_graph(edges, n);
	// Function call
	dijkstra(adj, 0);

	return 0;
}

