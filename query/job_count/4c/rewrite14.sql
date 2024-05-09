create or replace view aggView2431634088666255109 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7554535412050100022 as select movie_id as v14 from movie_keyword as mk, aggView2431634088666255109 where mk.keyword_id=aggView2431634088666255109.v3;
create or replace view aggView5736728416569157962 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5841132474128765541 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5736728416569157962 where mi_idx.info_type_id=aggView5736728416569157962.v1 and info>'2.0';
create or replace view aggView2874782413146591551 as select id as v14 from title as t where production_year>1990;
create or replace view aggJoin6476550557371056281 as select v14, v9 from aggJoin5841132474128765541 join aggView2874782413146591551 using(v14);
create or replace view aggView7074616169805541300 as select v14, COUNT(*) as annot from aggJoin6476550557371056281 group by v14;
create or replace view aggJoin8112208711365945961 as select annot from aggJoin7554535412050100022 join aggView7074616169805541300 using(v14);
select SUM(annot) as v26 from aggJoin8112208711365945961;
