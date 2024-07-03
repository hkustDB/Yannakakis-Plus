create or replace view aggView3233822202030509282 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin525662080822773034 as select movie_id as v12 from movie_companies as mc, aggView3233822202030509282 where mc.company_id=aggView3233822202030509282.v1;
create or replace view aggView58063619263798607 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2574129512486481709 as select v12, v31 from aggJoin525662080822773034 join aggView58063619263798607 using(v12);
create or replace view aggView4563987172594694782 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8519513702038364249 as select movie_id as v12 from movie_keyword as mk, aggView4563987172594694782 where mk.keyword_id=aggView4563987172594694782.v18;
create or replace view aggView111070190937305394 as select v12, MIN(v31) as v31 from aggJoin2574129512486481709 group by v12,v31;
create or replace view aggJoin2213337508555328733 as select v31 from aggJoin8519513702038364249 join aggView111070190937305394 using(v12);
select MIN(v31) as v31 from aggJoin2213337508555328733;
