create or replace view aggView6191389186381382838 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8560653795807202174 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView6191389186381382838 where mi_idx.info_type_id=aggView6191389186381382838.v1 and info>'9.0';
create or replace view aggView9032725819478573474 as select v14, COUNT(*) as annot from aggJoin8560653795807202174 group by v14;
create or replace view aggJoin2220727781686961389 as select id as v14, production_year as v18, annot from title as t, aggView9032725819478573474 where t.id=aggView9032725819478573474.v14 and production_year>2010;
create or replace view aggView7236235052676254312 as select v14, SUM(annot) as annot from aggJoin2220727781686961389 group by v14;
create or replace view aggJoin1582311246166347050 as select keyword_id as v3, annot from movie_keyword as mk, aggView7236235052676254312 where mk.movie_id=aggView7236235052676254312.v14;
create or replace view aggView6814364911257143563 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3931087247327429371 as select annot from aggJoin1582311246166347050 join aggView6814364911257143563 using(v3);
select SUM(annot) as v26 from aggJoin3931087247327429371;
