create or replace view aggView1411453153512396464 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1501835743981348986 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView1411453153512396464 where mc.movie_id=aggView1411453153512396464.v12;
create or replace view aggView6329771029918439084 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin7814655206491144395 as select v12, v31 from aggJoin1501835743981348986 join aggView6329771029918439084 using(v1);
create or replace view aggView6301042223544414347 as select v12, MIN(v31) as v31 from aggJoin7814655206491144395 group by v12,v31;
create or replace view aggJoin6214005843567944656 as select keyword_id as v18, v31 from movie_keyword as mk, aggView6301042223544414347 where mk.movie_id=aggView6301042223544414347.v12;
create or replace view aggView441181437531104836 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8193858627907361344 as select v31 from aggJoin6214005843567944656 join aggView441181437531104836 using(v18);
select MIN(v31) as v31 from aggJoin8193858627907361344;
