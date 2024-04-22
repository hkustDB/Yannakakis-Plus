create or replace view aggView729034500047517513 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin8004711212764851329 as (
with aggView7634525891410807782 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView7634525891410807782 where t.kind_id=aggView7634525891410807782.v28 and production_year>2005);
create or replace view aggJoin3295395779452130356 as (
with aggView1046820213400996107 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView1046820213400996107 where mi_idx.info_type_id=aggView1046820213400996107.v23);
create or replace view aggJoin3938820688365195889 as (
with aggView1481757221072778342 as (select v47, v33 from aggJoin3295395779452130356 group by v47,v33)
select v47, v33 from aggView1481757221072778342 where v33>'8.0');
create or replace view aggJoin5382599691927537182 as (
with aggView826633450431323746 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView826633450431323746 where cc.status_id=aggView826633450431323746.v7);
create or replace view aggJoin335439216752467907 as (
with aggView3699659822347099062 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin5382599691927537182 join aggView3699659822347099062 using(v5));
create or replace view aggJoin6799086505250208063 as (
with aggView2970750480399435013 as (select v47 from aggJoin335439216752467907 group by v47)
select v47, v48, v51 from aggJoin8004711212764851329 join aggView2970750480399435013 using(v47));
create or replace view aggView1380922648045251428 as select v47, v48 from aggJoin6799086505250208063 group by v47,v48;
create or replace view aggJoin6978396251105396443 as (
with aggView4112882326058910014 as (select v9, MIN(v10) as v59 from aggView729034500047517513 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView4112882326058910014 where ci.person_role_id=aggView4112882326058910014.v9);
create or replace view aggJoin4883463736973277284 as (
with aggView4247941165692021928 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView4247941165692021928 where mk.keyword_id=aggView4247941165692021928.v25);
create or replace view aggJoin3422036347745102652 as (
with aggView8496372769750621005 as (select v47 from aggJoin4883463736973277284 group by v47)
select v38, v47, v59 as v59 from aggJoin6978396251105396443 join aggView8496372769750621005 using(v47));
create or replace view aggJoin2661324667113989489 as (
with aggView3896143791663656381 as (select id as v38 from name as n)
select v47, v59 from aggJoin3422036347745102652 join aggView3896143791663656381 using(v38));
create or replace view aggJoin2770601972799095947 as (
with aggView440099609867592107 as (select v47, MIN(v59) as v59 from aggJoin2661324667113989489 group by v47,v59)
select v47, v33, v59 from aggJoin3938820688365195889 join aggView440099609867592107 using(v47));
create or replace view aggJoin3331285307687692934 as (
with aggView4751589378838232701 as (select v47, MIN(v59) as v59, MIN(v33) as v60 from aggJoin2770601972799095947 group by v47,v59)
select v48, v59, v60 from aggView1380922648045251428 join aggView4751589378838232701 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v48) as v61 from aggJoin3331285307687692934;
