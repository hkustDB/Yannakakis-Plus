create or replace view aggView4698409526926299935 as select id as v12, title as v31 from title as t;
create or replace view aggJoin133873116461605575 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView4698409526926299935 where mc.movie_id=aggView4698409526926299935.v12;
create or replace view aggView1948771349444121915 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1947198630305093929 as select movie_id as v12 from movie_keyword as mk, aggView1948771349444121915 where mk.keyword_id=aggView1948771349444121915.v18;
create or replace view aggView8637015507850419524 as select v12 from aggJoin1947198630305093929 group by v12;
create or replace view aggJoin2178104779167625938 as select v1, v31 as v31 from aggJoin133873116461605575 join aggView8637015507850419524 using(v12);
create or replace view aggView1760719813421581782 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin4011068318707591813 as select v31 from aggJoin2178104779167625938 join aggView1760719813421581782 using(v1);
select MIN(v31) as v31 from aggJoin4011068318707591813;
