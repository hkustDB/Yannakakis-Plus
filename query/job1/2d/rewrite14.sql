create or replace view aggView9016694143085413652 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3429161988491431038 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView9016694143085413652 where mc.movie_id=aggView9016694143085413652.v12;
create or replace view aggView4766040634138867033 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin338879751708239754 as select v12, v31 from aggJoin3429161988491431038 join aggView4766040634138867033 using(v1);
create or replace view aggView6998520502007064224 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin794171482259615799 as select movie_id as v12 from movie_keyword as mk, aggView6998520502007064224 where mk.keyword_id=aggView6998520502007064224.v18;
create or replace view aggView1277442118663228695 as select v12 from aggJoin794171482259615799 group by v12;
create or replace view aggJoin5578640670474919367 as select v31 as v31 from aggJoin338879751708239754 join aggView1277442118663228695 using(v12);
select MIN(v31) as v31 from aggJoin5578640670474919367;
