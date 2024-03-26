create or replace view aggView6267583548637531906 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6367071362529329469 as select movie_id as v12 from movie_keyword as mk, aggView6267583548637531906 where mk.keyword_id=aggView6267583548637531906.v18;
create or replace view aggView3755682904289033997 as select v12 from aggJoin6367071362529329469 group by v12;
create or replace view aggJoin1427588861960039967 as select id as v12, title as v20 from title as t, aggView3755682904289033997 where t.id=aggView3755682904289033997.v12;
create or replace view aggView675884804662410013 as select v12, MIN(v20) as v31 from aggJoin1427588861960039967 group by v12;
create or replace view aggJoin4752679789385838562 as select company_id as v1, v31 from movie_companies as mc, aggView675884804662410013 where mc.movie_id=aggView675884804662410013.v12;
create or replace view aggView4616072966339756168 as select v1, MIN(v31) as v31 from aggJoin4752679789385838562 group by v1;
create or replace view aggJoin6753238987706400720 as select country_code as v3, v31 from company_name as cn, aggView4616072966339756168 where cn.id=aggView4616072966339756168.v1 and country_code= '[de]';
select MIN(v31) as v31 from aggJoin6753238987706400720;
