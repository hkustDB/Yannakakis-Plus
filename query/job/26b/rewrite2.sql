create or replace view aggView8146378869372042162 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin8453624889701861997 as (
with aggView1750067819885511053 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1750067819885511053 where t.kind_id=aggView1750067819885511053.v28 and production_year>2005);
create or replace view aggView5277224903569241923 as select v47, v48 from aggJoin8453624889701861997 group by v47,v48;
create or replace view aggJoin2784160656689566877 as (
with aggView7044528632023083692 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView7044528632023083692 where mk.keyword_id=aggView7044528632023083692.v25);
create or replace view aggJoin2062787793035068617 as (
with aggView1396826913030474429 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView1396826913030474429 where mi_idx.info_type_id=aggView1396826913030474429.v23);
create or replace view aggJoin8824247647060606611 as (
with aggView5793955947852177313 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView5793955947852177313 where cc.status_id=aggView5793955947852177313.v7);
create or replace view aggJoin7279824857319740697 as (
with aggView2105139016188023533 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin8824247647060606611 join aggView2105139016188023533 using(v5));
create or replace view aggJoin4674959969818148273 as (
with aggView1179382375296792369 as (select v47 from aggJoin7279824857319740697 group by v47)
select v47 from aggJoin2784160656689566877 join aggView1179382375296792369 using(v47));
create or replace view aggJoin8663591725291540357 as (
with aggView6772515325203431286 as (select v47 from aggJoin4674959969818148273 group by v47)
select v47, v33 from aggJoin2062787793035068617 join aggView6772515325203431286 using(v47));
create or replace view aggJoin1497317475911480658 as (
with aggView6227340763565215683 as (select v47, v33 from aggJoin8663591725291540357 group by v47,v33)
select v47, v33 from aggView6227340763565215683 where v33>'8.0');
create or replace view aggJoin8586374901962238901 as (
with aggView4421462877037136491 as (select v47, MIN(v33) as v60 from aggJoin1497317475911480658 group by v47)
select person_id as v38, movie_id as v47, person_role_id as v9, v60 from cast_info as ci, aggView4421462877037136491 where ci.movie_id=aggView4421462877037136491.v47);
create or replace view aggJoin8957521286394395317 as (
with aggView6876951318151849096 as (select v47, MIN(v48) as v61 from aggView5277224903569241923 group by v47)
select v38, v9, v60 as v60, v61 from aggJoin8586374901962238901 join aggView6876951318151849096 using(v47));
create or replace view aggJoin2524076665292524836 as (
with aggView2697712550133942981 as (select id as v38 from name as n)
select v9, v60, v61 from aggJoin8957521286394395317 join aggView2697712550133942981 using(v38));
create or replace view aggJoin5489249546101271799 as (
with aggView8294781858418686702 as (select v9, MIN(v60) as v60, MIN(v61) as v61 from aggJoin2524076665292524836 group by v9,v61,v60)
select v10, v60, v61 from aggView8146378869372042162 join aggView8294781858418686702 using(v9));
select MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin5489249546101271799;
