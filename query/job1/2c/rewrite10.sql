create or replace view aggView4640185718255180687 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin922309905008187677 as select movie_id as v12 from movie_companies as mc, aggView4640185718255180687 where mc.company_id=aggView4640185718255180687.v1;
create or replace view aggView6718365778276498237 as select v12 from aggJoin922309905008187677 group by v12;
create or replace view aggJoin5632455310100579521 as select id as v12, title as v20 from title as t, aggView6718365778276498237 where t.id=aggView6718365778276498237.v12;
create or replace view aggView6753298130140540930 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4089560435292556145 as select movie_id as v12 from movie_keyword as mk, aggView6753298130140540930 where mk.keyword_id=aggView6753298130140540930.v18;
create or replace view aggView3955945947945614358 as select v12 from aggJoin4089560435292556145 group by v12;
create or replace view aggJoin5476175178841486834 as select v20 from aggJoin5632455310100579521 join aggView3955945947945614358 using(v12);
select MIN(v20) as v31 from aggJoin5476175178841486834;
