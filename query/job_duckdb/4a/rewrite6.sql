create or replace view aggView5152162111333975270 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5503769832386399315 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5152162111333975270 where mi_idx.info_type_id=aggView5152162111333975270.v1 and info>'5.0';
create or replace view aggView2774650528252131700 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin6542265943647285162 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView2774650528252131700 where mk.movie_id=aggView2774650528252131700.v14;
create or replace view aggView1343048065857706595 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5346188306914908159 as select v14, v27 from aggJoin6542265943647285162 join aggView1343048065857706595 using(v3);
create or replace view aggView5875698510452007001 as select v14, MIN(v9) as v26 from aggJoin5503769832386399315 group by v14;
create or replace view aggJoin3862124375588991941 as select v27 as v27, v26 from aggJoin5346188306914908159 join aggView5875698510452007001 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3862124375588991941;
