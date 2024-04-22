create or replace view aggView167954642291815287 as select title as v26, id as v11 from title as t2;
create or replace view aggJoin7001952463483730106 as (
with aggView1568607877736217911 as (select id as v8 from keyword as k where keyword= '10,000-mile-club')
select movie_id as v13 from movie_keyword as mk, aggView1568607877736217911 where mk.keyword_id=aggView1568607877736217911.v8);
create or replace view aggJoin1945655378033654953 as (
with aggView6956956243043843771 as (select v13 from aggJoin7001952463483730106 group by v13)
select id as v13, title as v14 from title as t1, aggView6956956243043843771 where t1.id=aggView6956956243043843771.v13);
create or replace view aggView2222624218115169712 as select v13, v14 from aggJoin1945655378033654953 group by v13,v14;
create or replace view aggJoin7855028213498022052 as (
with aggView8004995576865203889 as (select v13, MIN(v14) as v38 from aggView2222624218115169712 group by v13)
select linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView8004995576865203889 where ml.movie_id=aggView8004995576865203889.v13);
create or replace view aggJoin2828989313602739017 as (
with aggView1226922601600447690 as (select v11, MIN(v26) as v39 from aggView167954642291815287 group by v11)
select v4, v38 as v38, v39 from aggJoin7855028213498022052 join aggView1226922601600447690 using(v11));
create or replace view aggJoin6789236383244277619 as (
with aggView2714418106328734067 as (select v4, MIN(v38) as v38, MIN(v39) as v39 from aggJoin2828989313602739017 group by v4,v39,v38)
select link as v5, v38, v39 from link_type as lt, aggView2714418106328734067 where lt.id=aggView2714418106328734067.v4);
select MIN(v5) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin6789236383244277619;
