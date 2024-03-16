create or replace view aggView4930561263880174300 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin792139664921430466 as select movie_id as v12 from movie_companies as mc, aggView4930561263880174300 where mc.company_id=aggView4930561263880174300.v1;
create or replace view aggView5426185718658716191 as select v12 from aggJoin792139664921430466 group by v12;
create or replace view aggJoin5752009456397742200 as select id as v12, title as v20 from title as t, aggView5426185718658716191 where t.id=aggView5426185718658716191.v12;
create or replace view aggView443522662419160615 as select v12, MIN(v20) as v31 from aggJoin5752009456397742200 group by v12;
create or replace view aggJoin1113340681399189803 as select keyword_id as v18, v31 from movie_keyword as mk, aggView443522662419160615 where mk.movie_id=aggView443522662419160615.v12;
create or replace view aggView1460354128391986128 as select v18, MIN(v31) as v31 from aggJoin1113340681399189803 group by v18;
create or replace view aggJoin8565131834546133174 as select keyword as v9, v31 from keyword as k, aggView1460354128391986128 where k.id=aggView1460354128391986128.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin8565131834546133174;
