create or replace view aggView5166003939540487210 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin1171340937347942157 as (
with aggView4202622866052914357 as (select name as v49, id as v48 from name as n where gender= 'f')
select v48, v49 from aggView4202622866052914357 where v49 LIKE '%An%');
create or replace view aggJoin6185014340296330767 as (
with aggView9106793560583560930 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView9106793560583560930 where mi.info_type_id=aggView9106793560583560930.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7290475043053859698 as (
with aggView8863703908041085993 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView8863703908041085993 where mk.keyword_id=aggView8863703908041085993.v32);
create or replace view aggJoin8799518374953466854 as (
with aggView1818693453151280187 as (select v59 from aggJoin7290475043053859698 group by v59)
select v59, v43 from aggJoin6185014340296330767 join aggView1818693453151280187 using(v59));
create or replace view aggJoin906087369196939138 as (
with aggView3503554778815143328 as (select v59 from aggJoin8799518374953466854 group by v59)
select movie_id as v59, company_id as v23 from movie_companies as mc, aggView3503554778815143328 where mc.movie_id=aggView3503554778815143328.v59);
create or replace view aggJoin42300069233895101 as (
with aggView3851053097059156881 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select v59 from aggJoin906087369196939138 join aggView3851053097059156881 using(v23));
create or replace view aggJoin8568116142514699894 as (
with aggView6234382474578012474 as (select v59 from aggJoin42300069233895101 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView6234382474578012474 where t.id=aggView6234382474578012474.v59 and production_year>2010);
create or replace view aggJoin8265481558148491586 as (
with aggView3703640966971775073 as (select v59, v60 from aggJoin8568116142514699894 group by v59,v60)
select v59, v60 from aggView3703640966971775073 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggJoin5987966821591759488 as (
with aggView837679248847822405 as (select v9, MIN(v10) as v71 from aggView5166003939540487210 group by v9)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView837679248847822405 where ci.person_role_id=aggView837679248847822405.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2848695296157942348 as (
with aggView2782952642777475509 as (select v59, MIN(v60) as v73 from aggJoin8265481558148491586 group by v59)
select v48, v20, v57, v71 as v71, v73 from aggJoin5987966821591759488 join aggView2782952642777475509 using(v59));
create or replace view aggJoin6768879876707409214 as (
with aggView7094399340607829531 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v20, v71, v73 from aggJoin2848695296157942348 join aggView7094399340607829531 using(v57));
create or replace view aggJoin6699211404247404013 as (
with aggView7764678461757223799 as (select person_id as v48 from aka_name as an group by person_id)
select v48, v20, v71 as v71, v73 as v73 from aggJoin6768879876707409214 join aggView7764678461757223799 using(v48));
create or replace view aggJoin6394462002010112603 as (
with aggView3335311515371266910 as (select v48, MIN(v71) as v71, MIN(v73) as v73 from aggJoin6699211404247404013 group by v48,v71,v73)
select v49, v71, v73 from aggJoin1171340937347942157 join aggView3335311515371266910 using(v48));
select MIN(v71) as v71,MIN(v49) as v72,MIN(v73) as v73 from aggJoin6394462002010112603;
