create or replace view aggView6370911765845097498 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggView7095554249672194761 as select id as v38, name as v39 from name as n;
create or replace view aggJoin6266613770836845701 as (
with aggView8578256138082548521 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView8578256138082548521 where t.kind_id=aggView8578256138082548521.v28 and production_year>2000);
create or replace view aggView154272199281101775 as select v48, v47 from aggJoin6266613770836845701 group by v48,v47;
create or replace view aggJoin8679159206168647871 as (
with aggView3251832518388718996 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView3251832518388718996 where mi_idx.info_type_id=aggView3251832518388718996.v23);
create or replace view aggJoin6268665830170633004 as (
with aggView3711204750704860886 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView3711204750704860886 where cc.subject_id=aggView3711204750704860886.v5);
create or replace view aggJoin3646460965537219159 as (
with aggView1066776364876544876 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin6268665830170633004 join aggView1066776364876544876 using(v7));
create or replace view aggJoin7884067692679061789 as (
with aggView731172205698032157 as (select v47 from aggJoin3646460965537219159 group by v47)
select movie_id as v47, keyword_id as v25 from movie_keyword as mk, aggView731172205698032157 where mk.movie_id=aggView731172205698032157.v47);
create or replace view aggJoin3113835321722826107 as (
with aggView3369060607769482057 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47 from aggJoin7884067692679061789 join aggView3369060607769482057 using(v25));
create or replace view aggJoin7802061943367507290 as (
with aggView8787888302245539605 as (select v47 from aggJoin3113835321722826107 group by v47)
select v47, v33 from aggJoin8679159206168647871 join aggView8787888302245539605 using(v47));
create or replace view aggJoin378108253555697405 as (
with aggView1191849103239166326 as (select v33, v47 from aggJoin7802061943367507290 group by v33,v47)
select v47, v33 from aggView1191849103239166326 where v33>'7.0');
create or replace view aggJoin2099460332453670202 as (
with aggView8920886063683063880 as (select v47, MIN(v48) as v62 from aggView154272199281101775 group by v47)
select person_id as v38, movie_id as v47, person_role_id as v9, v62 from cast_info as ci, aggView8920886063683063880 where ci.movie_id=aggView8920886063683063880.v47);
create or replace view aggJoin6621556627583098339 as (
with aggView5589068285520256897 as (select v9, MIN(v10) as v59 from aggView6370911765845097498 group by v9)
select v38, v47, v62 as v62, v59 from aggJoin2099460332453670202 join aggView5589068285520256897 using(v9));
create or replace view aggJoin8598310688858298174 as (
with aggView5823798448766793674 as (select v47, MIN(v33) as v60 from aggJoin378108253555697405 group by v47)
select v38, v62 as v62, v59 as v59, v60 from aggJoin6621556627583098339 join aggView5823798448766793674 using(v47));
create or replace view aggJoin6234265983798908827 as (
with aggView3860575561378072712 as (select v38, MIN(v62) as v62, MIN(v59) as v59, MIN(v60) as v60 from aggJoin8598310688858298174 group by v38,v59,v60,v62)
select v39, v62, v59, v60 from aggView7095554249672194761 join aggView3860575561378072712 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v39) as v61,MIN(v62) as v62 from aggJoin6234265983798908827;
