create or replace view aggView5531947648430282675 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7609342993935748622 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView5531947648430282675 where mc.movie_id=aggView5531947648430282675.v12;
create or replace view aggView5399374941427147985 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin2300064415238907037 as select v12, v31 from aggJoin7609342993935748622 join aggView5399374941427147985 using(v1);
create or replace view aggView4588430239355795576 as select v12, MIN(v31) as v31 from aggJoin2300064415238907037 group by v12;
create or replace view aggJoin5132517856080550478 as select keyword_id as v18, v31 from movie_keyword as mk, aggView4588430239355795576 where mk.movie_id=aggView4588430239355795576.v12;
create or replace view aggView2339036364205032204 as select v18, MIN(v31) as v31 from aggJoin5132517856080550478 group by v18;
create or replace view aggJoin7327141151417323612 as select keyword as v9, v31 from keyword as k, aggView2339036364205032204 where k.id=aggView2339036364205032204.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin7327141151417323612;
