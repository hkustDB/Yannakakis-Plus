create or replace view aggView3744641896599399731 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5328219118003339808 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView3744641896599399731 where mk.movie_id=aggView3744641896599399731.v12;
create or replace view aggView5730894966188445670 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4072808862105095582 as select v12, v31 from aggJoin5328219118003339808 join aggView5730894966188445670 using(v18);
create or replace view aggView6778261174656387878 as select v12, MIN(v31) as v31 from aggJoin4072808862105095582 group by v12;
create or replace view aggJoin3351417550042723145 as select company_id as v1, v31 from movie_companies as mc, aggView6778261174656387878 where mc.movie_id=aggView6778261174656387878.v12;
create or replace view aggView5518443450180954121 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin5550529190501002560 as select v31 from aggJoin3351417550042723145 join aggView5518443450180954121 using(v1);
select MIN(v31) as v31 from aggJoin5550529190501002560;
