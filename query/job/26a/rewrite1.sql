create or replace view aggView7020183169027642000 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggView7760550315816454130 as select id as v38, name as v39 from name as n;
create or replace view aggJoin6470999163739783866 as (
with aggView6634477410028823455 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView6634477410028823455 where t.kind_id=aggView6634477410028823455.v28 and production_year>2000);
create or replace view aggView1736712739957134361 as select v48, v47 from aggJoin6470999163739783866 group by v48,v47;
create or replace view aggJoin7237477439838187618 as (
with aggView5159486762713788465 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5159486762713788465 where mi_idx.info_type_id=aggView5159486762713788465.v23);
create or replace view aggJoin6807166574322384975 as (
with aggView4497669482634872385 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView4497669482634872385 where cc.subject_id=aggView4497669482634872385.v5);
create or replace view aggJoin6965056577695359618 as (
with aggView4441873104857689513 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin6807166574322384975 join aggView4441873104857689513 using(v7));
create or replace view aggJoin4278313609826857298 as (
with aggView521046081199409042 as (select v47 from aggJoin6965056577695359618 group by v47)
select movie_id as v47, keyword_id as v25 from movie_keyword as mk, aggView521046081199409042 where mk.movie_id=aggView521046081199409042.v47);
create or replace view aggJoin4302224478900075617 as (
with aggView6626763115906428109 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47 from aggJoin4278313609826857298 join aggView6626763115906428109 using(v25));
create or replace view aggJoin141414898582606128 as (
with aggView3401301958919140122 as (select v47 from aggJoin4302224478900075617 group by v47)
select v47, v33 from aggJoin7237477439838187618 join aggView3401301958919140122 using(v47));
create or replace view aggJoin4637199462558755376 as (
with aggView5481262702002457321 as (select v33, v47 from aggJoin141414898582606128 group by v33,v47)
select v47, v33 from aggView5481262702002457321 where v33>'7.0');
create or replace view aggJoin1216549217102609532 as (
with aggView6224598463822435158 as (select v9, MIN(v10) as v59 from aggView7020183169027642000 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView6224598463822435158 where ci.person_role_id=aggView6224598463822435158.v9);
create or replace view aggJoin1711815137699216380 as (
with aggView8607872907517673849 as (select v38, MIN(v39) as v61 from aggView7760550315816454130 group by v38)
select v47, v59 as v59, v61 from aggJoin1216549217102609532 join aggView8607872907517673849 using(v38));
create or replace view aggJoin7917438201130090835 as (
with aggView2594525396421406867 as (select v47, MIN(v33) as v60 from aggJoin4637199462558755376 group by v47)
select v48, v47, v60 from aggView1736712739957134361 join aggView2594525396421406867 using(v47));
create or replace view aggJoin3682652562386801514 as (
with aggView8474108628540398872 as (select v47, MIN(v59) as v59, MIN(v61) as v61 from aggJoin1711815137699216380 group by v47,v59,v61)
select v48, v60 as v60, v59, v61 from aggJoin7917438201130090835 join aggView8474108628540398872 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v48) as v62 from aggJoin3682652562386801514;
