create or replace view aggView8402251739463981878 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin7965696034881320274 as select movie_id as v12 from movie_companies as mc, aggView8402251739463981878 where mc.company_id=aggView8402251739463981878.v1;
create or replace view aggView6968449642563541487 as select v12 from aggJoin7965696034881320274 group by v12;
create or replace view aggJoin5762800294017001227 as select id as v12, title as v20 from title as t, aggView6968449642563541487 where t.id=aggView6968449642563541487.v12;
create or replace view aggView8089775995924814073 as select v12, MIN(v20) as v31 from aggJoin5762800294017001227 group by v12;
create or replace view aggJoin998208588140108822 as select keyword_id as v18, v31 from movie_keyword as mk, aggView8089775995924814073 where mk.movie_id=aggView8089775995924814073.v12;
create or replace view aggView6018232674863434411 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2883776068363790034 as select v31 from aggJoin998208588140108822 join aggView6018232674863434411 using(v18);
select MIN(v31) as v31 from aggJoin2883776068363790034;
