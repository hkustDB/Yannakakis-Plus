create or replace view aggJoin1031198428529096201 as (
with aggView3605656402081852560 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView3605656402081852560 where ci.person_id=aggView3605656402081852560.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4578632058649644998 as (
with aggView7496342844391670134 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView7496342844391670134 where mi.info_type_id=aggView7496342844391670134.v8 and info= 'Horror');
create or replace view aggJoin6700703305603721388 as (
with aggView1748860460219586792 as (select v37, MIN(v18) as v49 from aggJoin4578632058649644998 group by v37)
select movie_id as v37, info_type_id as v10, info as v23, v49 from movie_info_idx as mi_idx, aggView1748860460219586792 where mi_idx.movie_id=aggView1748860460219586792.v37);
create or replace view aggJoin4396287039962594838 as (
with aggView7557205219858355897 as (select v37, MIN(v51) as v51 from aggJoin1031198428529096201 group by v37,v51)
select id as v37, title as v38, production_year as v41, v51 from title as t, aggView7557205219858355897 where t.id=aggView7557205219858355897.v37 and production_year>2010 and title LIKE 'Vampire%');
create or replace view aggJoin4821703929239230339 as (
with aggView9008419288342656933 as (select v37, MIN(v51) as v51, MIN(v38) as v52 from aggJoin4396287039962594838 group by v37,v51)
select movie_id as v37, keyword_id as v12, v51, v52 from movie_keyword as mk, aggView9008419288342656933 where mk.movie_id=aggView9008419288342656933.v37);
create or replace view aggJoin6686602405406242775 as (
with aggView8244540836649019803 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select v37, v51, v52 from aggJoin4821703929239230339 join aggView8244540836649019803 using(v12));
create or replace view aggJoin8019490161293631469 as (
with aggView2358861101180441349 as (select id as v10 from info_type as it2 where info= 'votes')
select v37, v23, v49 from aggJoin6700703305603721388 join aggView2358861101180441349 using(v10));
create or replace view aggJoin7249789391289459955 as (
with aggView157377009761067165 as (select v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin8019490161293631469 group by v37,v49)
select v51 as v51, v52 as v52, v49, v50 from aggJoin6686602405406242775 join aggView157377009761067165 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin7249789391289459955;
