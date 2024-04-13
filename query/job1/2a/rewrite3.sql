create or replace view aggView5923513490366321448 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin309814510584324370 as select movie_id as v12 from movie_companies as mc, aggView5923513490366321448 where mc.company_id=aggView5923513490366321448.v1;
create or replace view aggView6358820541950852320 as select v12 from aggJoin309814510584324370 group by v12;
create or replace view aggJoin4706114967878476438 as select id as v12, title as v20 from title as t, aggView6358820541950852320 where t.id=aggView6358820541950852320.v12;
create or replace view aggView2961773661563347023 as select v12, MIN(v20) as v31 from aggJoin4706114967878476438 group by v12;
create or replace view aggJoin794793685322855638 as select keyword_id as v18, v31 from movie_keyword as mk, aggView2961773661563347023 where mk.movie_id=aggView2961773661563347023.v12;
create or replace view aggView3185777167970960108 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin415896353273175051 as select v31 from aggJoin794793685322855638 join aggView3185777167970960108 using(v18);
select MIN(v31) as v31 from aggJoin415896353273175051;
