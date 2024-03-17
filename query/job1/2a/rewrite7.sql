create or replace view aggView6378864005961402795 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin3588819296587066632 as select movie_id as v12 from movie_companies as mc, aggView6378864005961402795 where mc.company_id=aggView6378864005961402795.v1;
create or replace view aggView8007805336020244255 as select v12 from aggJoin3588819296587066632 group by v12;
create or replace view aggJoin4974502560683572870 as select id as v12, title as v20 from title as t, aggView8007805336020244255 where t.id=aggView8007805336020244255.v12;
create or replace view aggView9013666553271028858 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5164958632481650482 as select movie_id as v12 from movie_keyword as mk, aggView9013666553271028858 where mk.keyword_id=aggView9013666553271028858.v18;
create or replace view aggView1643570563156278124 as select v12 from aggJoin5164958632481650482 group by v12;
create or replace view aggJoin8382857649922327269 as select v20 from aggJoin4974502560683572870 join aggView1643570563156278124 using(v12);
select MIN(v20) as v31 from aggJoin8382857649922327269;
