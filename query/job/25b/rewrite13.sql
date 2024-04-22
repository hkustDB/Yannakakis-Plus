create or replace view aggJoin1809620145300164703 as (
with aggView7075640814147998729 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView7075640814147998729 where ci.person_id=aggView7075640814147998729.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1619138700294969614 as (
with aggView2663636556149896765 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView2663636556149896765 where mi.info_type_id=aggView2663636556149896765.v8 and info= 'Horror');
create or replace view aggJoin1300538377119802183 as (
with aggView735560288849072211 as (select v37, MIN(v51) as v51 from aggJoin1809620145300164703 group by v37,v51)
select id as v37, title as v38, production_year as v41, v51 from title as t, aggView735560288849072211 where t.id=aggView735560288849072211.v37 and production_year>2010 and title LIKE 'Vampire%');
create or replace view aggJoin3600057391457379350 as (
with aggView3385263263072635592 as (select v37, MIN(v51) as v51, MIN(v38) as v52 from aggJoin1300538377119802183 group by v37,v51)
select v37, v18, v51, v52 from aggJoin1619138700294969614 join aggView3385263263072635592 using(v37));
create or replace view aggJoin7373189056297998100 as (
with aggView2819654010125448825 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView2819654010125448825 where mk.keyword_id=aggView2819654010125448825.v12);
create or replace view aggJoin3183826222000829181 as (
with aggView308593698314361295 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView308593698314361295 where mi_idx.info_type_id=aggView308593698314361295.v10);
create or replace view aggJoin1512785004994482285 as (
with aggView7003825681093626635 as (select v37, MIN(v23) as v50 from aggJoin3183826222000829181 group by v37)
select v37, v18, v51 as v51, v52 as v52, v50 from aggJoin3600057391457379350 join aggView7003825681093626635 using(v37));
create or replace view aggJoin3515501936143183375 as (
with aggView2335460992622996253 as (select v37, MIN(v51) as v51, MIN(v52) as v52, MIN(v50) as v50, MIN(v18) as v49 from aggJoin1512785004994482285 group by v37,v50,v52,v51)
select v51, v52, v50, v49 from aggJoin7373189056297998100 join aggView2335460992622996253 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin3515501936143183375;
