create or replace view aggJoin9051329295078173898 as (
with aggView67045406425529241 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView67045406425529241 where mc.company_id=aggView67045406425529241.v17);
create or replace view aggJoin3470671686321591543 as (
with aggView4704106037975020011 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView4704106037975020011 where ml.link_type_id=aggView4704106037975020011.v13);
create or replace view aggJoin3228908962788841601 as (
with aggView7595243491536060581 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView7595243491536060581 where mk.keyword_id=aggView7595243491536060581.v22);
create or replace view aggJoin1969572320857595936 as (
with aggView4361894700261369028 as (select v24, MIN(v40) as v40 from aggJoin3470671686321591543 group by v24,v40)
select v24, v18, v39 as v39, v40 from aggJoin9051329295078173898 join aggView4361894700261369028 using(v24));
create or replace view aggJoin234295720210380077 as (
with aggView966015405700135243 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39, v40 from aggJoin1969572320857595936 join aggView966015405700135243 using(v18));
create or replace view aggJoin7016436320877879165 as (
with aggView1629356210035161111 as (select v24, MIN(v39) as v39, MIN(v40) as v40 from aggJoin234295720210380077 group by v24,v39,v40)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView1629356210035161111 where t.id=aggView1629356210035161111.v24 and title LIKE '%Money%' and production_year= 1998);
create or replace view aggJoin6300276085676086656 as (
with aggView1656622113869725913 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin7016436320877879165 group by v24,v39,v40)
select v39, v40, v41 from aggJoin3228908962788841601 join aggView1656622113869725913 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin6300276085676086656;
