create or replace view aggView1570831091627786354 as select dst as v4, src as v2 from Graph as g2;
create or replace view aggJoin5670948511961847434 as select dst as v2 from Graph as g3, aggView1570831091627786354 where g3.src=aggView1570831091627786354.v4 and g3.dst=aggView1570831091627786354.v2;
create or replace view aggView4796801088049660319 as select src as v8, dst as v2 from Graph as g1;
create or replace view aggJoin4316934452763107851 as select src as v2 from Graph as g4, aggView4796801088049660319 where g4.dst=aggView4796801088049660319.v8 and g4.src=aggView4796801088049660319.v2;
create or replace view aggView1760631369500023970 as select v2, COUNT(*) as annot from aggJoin5670948511961847434 group by v2;
create or replace view aggJoin7069105811771506981 as select annot from aggJoin4316934452763107851 join aggView1760631369500023970 using(v2);
select SUM(annot) as v9 from aggJoin7069105811771506981;
