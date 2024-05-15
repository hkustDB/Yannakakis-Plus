create or replace view aggView4028835319651650789 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin5229132529682558763 as select movie_id as v12 from movie_companies as mc, aggView4028835319651650789 where mc.company_id=aggView4028835319651650789.v1;
create or replace view aggView1590307420193116285 as select v12 from aggJoin5229132529682558763 group by v12;
create or replace view aggJoin7670959837504754986 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView1590307420193116285 where mk.movie_id=aggView1590307420193116285.v12;
create or replace view aggView5229307978216751191 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8131025255702056507 as select v18, v31 from aggJoin7670959837504754986 join aggView5229307978216751191 using(v12);
create or replace view aggView6387424257696976914 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3009095850562115102 as select v31 from aggJoin8131025255702056507 join aggView6387424257696976914 using(v18);
select MIN(v31) as v31 from aggJoin3009095850562115102;
