create or replace view semiJoinView2330678706138347557 as select src as v2, dst as v8 from Graph AS g4 where (src, dst) in (select (dst, src) from Graph AS g1);
create or replace view semiJoinView1280770255524896079 as select src as v4, dst as v2 from Graph AS g3 where (dst) in (select (v2) from semiJoinView2330678706138347557);
create or replace view semiJoinView5080800634291788469 as select v4, v2 from semiJoinView1280770255524896079 where (v2, v4) in (select (src, dst) from Graph AS g2);
create or replace view semiEnum1514084787936042341 as select v2, v4 from semiJoinView5080800634291788469, Graph as g2 where g2.src=semiJoinView5080800634291788469.v2 and g2.dst=semiJoinView5080800634291788469.v4;
create or replace view semiEnum8482817798000641304 as select v2, v8, v4 from semiEnum1514084787936042341 join semiJoinView2330678706138347557 using(v2);
create or replace view semiEnum5908477091570635090 as select v8, v4, v2 from semiEnum8482817798000641304, Graph as g1 where g1.dst=semiEnum8482817798000641304.v2 and g1.src=semiEnum8482817798000641304.v8;
select v8, v2, v2, v4, v4, v2, v2, v8 from semiEnum5908477091570635090;
