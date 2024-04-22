create or replace view aggView3630559256461653905 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin901252615555342381 as (
with aggView5974031531908897193 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView5974031531908897193 where cc.status_id=aggView5974031531908897193.v7);
create or replace view aggJoin5687579378036267514 as (
with aggView7475668366512970387 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin901252615555342381 join aggView7475668366512970387 using(v5));
create or replace view aggJoin6631368359046017524 as (
with aggView5032482903600771800 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5032482903600771800 where mi_idx.info_type_id=aggView5032482903600771800.v23);
create or replace view aggJoin7000353604260714317 as (
with aggView1049393435468008664 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1049393435468008664 where t.kind_id=aggView1049393435468008664.v28 and production_year>2000);
create or replace view aggView6447743934405476868 as select v48, v47 from aggJoin7000353604260714317 group by v48,v47;
create or replace view aggJoin4665548582984010713 as (
with aggView7577194878613227756 as (select v47 from aggJoin5687579378036267514 group by v47)
select v47, v33 from aggJoin6631368359046017524 join aggView7577194878613227756 using(v47));
create or replace view aggView6775976201558708648 as select v33, v47 from aggJoin4665548582984010713 group by v33,v47;
create or replace view aggJoin8820969757199444267 as (
with aggView5199771467292450211 as (select v47, MIN(v33) as v60 from aggView6775976201558708648 group by v47)
select v48, v47, v60 from aggView6447743934405476868 join aggView5199771467292450211 using(v47));
create or replace view aggJoin7631693647380249657 as (
with aggView8036897970568523167 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin8820969757199444267 group by v47,v60)
select person_id as v38, movie_id as v47, person_role_id as v9, v60, v61 from cast_info as ci, aggView8036897970568523167 where ci.movie_id=aggView8036897970568523167.v47);
create or replace view aggJoin204882803094029627 as (
with aggView3657628370376259766 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView3657628370376259766 where mk.keyword_id=aggView3657628370376259766.v25);
create or replace view aggJoin3673871492436277885 as (
with aggView308860862170837215 as (select v47 from aggJoin204882803094029627 group by v47)
select v38, v9, v60 as v60, v61 as v61 from aggJoin7631693647380249657 join aggView308860862170837215 using(v47));
create or replace view aggJoin2178838052329334899 as (
with aggView3704330660626343284 as (select id as v38 from name as n)
select v9, v60, v61 from aggJoin3673871492436277885 join aggView3704330660626343284 using(v38));
create or replace view aggJoin3433706842080388699 as (
with aggView3992923448320373000 as (select v9, MIN(v60) as v60, MIN(v61) as v61 from aggJoin2178838052329334899 group by v9,v61,v60)
select v10, v60, v61 from aggView3630559256461653905 join aggView3992923448320373000 using(v9));
select MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin3433706842080388699;
