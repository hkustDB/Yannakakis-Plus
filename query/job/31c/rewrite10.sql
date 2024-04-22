create or replace view aggView7116323027865330768 as select id as v49, title as v50 from title as t;
create or replace view aggView7824229297020793994 as select name as v41, id as v40 from name as n;
create or replace view aggJoin4588882165531005397 as (
with aggView4366898421724922678 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView4366898421724922678 where mk.keyword_id=aggView4366898421724922678.v19);
create or replace view aggJoin2673359102935485021 as (
with aggView24946646192971010 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView24946646192971010 where mi.info_type_id=aggView24946646192971010.v15);
create or replace view aggJoin8728887343231884614 as (
with aggView7902104059412945015 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView7902104059412945015 where mi_idx.info_type_id=aggView7902104059412945015.v17);
create or replace view aggView8647208884386446833 as select v49, v35 from aggJoin8728887343231884614 group by v49,v35;
create or replace view aggJoin2174149950461264188 as (
with aggView6123095987603794605 as (select v49 from aggJoin4588882165531005397 group by v49)
select v49, v30 from aggJoin2673359102935485021 join aggView6123095987603794605 using(v49));
create or replace view aggJoin3870627828540088342 as (
with aggView5509357272540769700 as (select v49, v30 from aggJoin2174149950461264188 group by v49,v30)
select v49, v30 from aggView5509357272540769700 where v30 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin7616447602317431330 as (
with aggView8157692827168698982 as (select v49, MIN(v30) as v61 from aggJoin3870627828540088342 group by v49)
select person_id as v40, movie_id as v49, note as v5, v61 from cast_info as ci, aggView8157692827168698982 where ci.movie_id=aggView8157692827168698982.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7685672085065762065 as (
with aggView3450551457911220995 as (select v40, MIN(v41) as v63 from aggView7824229297020793994 group by v40)
select v49, v5, v61 as v61, v63 from aggJoin7616447602317431330 join aggView3450551457911220995 using(v40));
create or replace view aggJoin7140782170043451923 as (
with aggView95532203752065980 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView95532203752065980 where mc.company_id=aggView95532203752065980.v8);
create or replace view aggJoin1826869866657703894 as (
with aggView7872901317956766653 as (select v49 from aggJoin7140782170043451923 group by v49)
select v49, v5, v61 as v61, v63 as v63 from aggJoin7685672085065762065 join aggView7872901317956766653 using(v49));
create or replace view aggJoin40076956208997989 as (
with aggView8807142619317256544 as (select v49, MIN(v61) as v61, MIN(v63) as v63 from aggJoin1826869866657703894 group by v49,v63,v61)
select v49, v35, v61, v63 from aggView8647208884386446833 join aggView8807142619317256544 using(v49));
create or replace view aggJoin3503754147933314099 as (
with aggView474676751841402134 as (select v49, MIN(v61) as v61, MIN(v63) as v63, MIN(v35) as v62 from aggJoin40076956208997989 group by v49,v63,v61)
select v50, v61, v63, v62 from aggView7116323027865330768 join aggView474676751841402134 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v50) as v64 from aggJoin3503754147933314099;
