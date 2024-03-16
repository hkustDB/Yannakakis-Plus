create or replace view aggView6709894430514519934 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6486536490004109949 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6709894430514519934 where mc.movie_id=aggView6709894430514519934.v12;
create or replace view aggView5190400833993636792 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin944309613516704105 as select v12, v31 from aggJoin6486536490004109949 join aggView5190400833993636792 using(v1);
create or replace view aggView2347917522318736999 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6834465463229622196 as select movie_id as v12 from movie_keyword as mk, aggView2347917522318736999 where mk.keyword_id=aggView2347917522318736999.v18;
create or replace view aggView937270329893300111 as select v12 from aggJoin6834465463229622196 group by v12;
create or replace view aggJoin8175280807828662896 as select v31 as v31 from aggJoin944309613516704105 join aggView937270329893300111 using(v12);
select MIN(v31) as v31 from aggJoin8175280807828662896;
