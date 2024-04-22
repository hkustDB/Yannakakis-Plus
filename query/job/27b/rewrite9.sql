create or replace view aggJoin4329617805198730003 as (
with aggView3691733601871726117 as (select id as v37, title as v54 from title as t where production_year= 1998)
select movie_id as v37, link_type_id as v21, v54 from movie_link as ml, aggView3691733601871726117 where ml.movie_id=aggView3691733601871726117.v37);
create or replace view aggJoin277511888853828224 as (
with aggView7166057916000871499 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select v37, v54, v53 from aggJoin4329617805198730003 join aggView7166057916000871499 using(v21));
create or replace view aggJoin3500683837337951844 as (
with aggView4588931769315099190 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView4588931769315099190 where mc.company_id=aggView4588931769315099190.v25);
create or replace view aggJoin4027377152197004409 as (
with aggView7412629169464439995 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView7412629169464439995 where cc.subject_id=aggView7412629169464439995.v5);
create or replace view aggJoin8330429560667373754 as (
with aggView8796194693285310644 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView8796194693285310644 where mk.keyword_id=aggView8796194693285310644.v35);
create or replace view aggJoin6300174538966837575 as (
with aggView3948344950895925853 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin4027377152197004409 join aggView3948344950895925853 using(v7));
create or replace view aggJoin522573984538135067 as (
with aggView4555068480824459761 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin3500683837337951844 join aggView4555068480824459761 using(v26));
create or replace view aggJoin4293317046938202001 as (
with aggView1592103451231445582 as (select v37, MIN(v52) as v52 from aggJoin522573984538135067 group by v37,v52)
select movie_id as v37, info as v31, v52 from movie_info as mi, aggView1592103451231445582 where mi.movie_id=aggView1592103451231445582.v37 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1872911929871583817 as (
with aggView3595720273966544673 as (select v37, MIN(v52) as v52 from aggJoin4293317046938202001 group by v37,v52)
select v37, v52 from aggJoin8330429560667373754 join aggView3595720273966544673 using(v37));
create or replace view aggJoin8253354681180479179 as (
with aggView8772951380477740240 as (select v37 from aggJoin6300174538966837575 group by v37)
select v37, v54 as v54, v53 as v53 from aggJoin277511888853828224 join aggView8772951380477740240 using(v37));
create or replace view aggJoin3772668784719031166 as (
with aggView1707834935758969080 as (select v37, MIN(v54) as v54, MIN(v53) as v53 from aggJoin8253354681180479179 group by v37,v53,v54)
select v52 as v52, v54, v53 from aggJoin1872911929871583817 join aggView1707834935758969080 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin3772668784719031166;
