create or replace view aggView694428595402867445 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1958813432462249055 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView694428595402867445 where mk.movie_id=aggView694428595402867445.v12;
create or replace view aggView3981011362515860157 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3244734988165728661 as select v12, v31 from aggJoin1958813432462249055 join aggView3981011362515860157 using(v18);
create or replace view aggView3951247696215684237 as select v12, MIN(v31) as v31 from aggJoin3244734988165728661 group by v12;
create or replace view aggJoin9136165532589507234 as select company_id as v1, v31 from movie_companies as mc, aggView3951247696215684237 where mc.movie_id=aggView3951247696215684237.v12;
create or replace view aggView3235827377158908654 as select v1, MIN(v31) as v31 from aggJoin9136165532589507234 group by v1;
create or replace view aggJoin7675066074370324859 as select country_code as v3, v31 from company_name as cn, aggView3235827377158908654 where cn.id=aggView3235827377158908654.v1 and country_code= '[sm]';
select MIN(v31) as v31 from aggJoin7675066074370324859;
