create or replace view aggView1922904510739103008 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin4355424958592999757 as select movie_id as v12 from movie_companies as mc, aggView1922904510739103008 where mc.company_id=aggView1922904510739103008.v1;
create or replace view aggView5056653734257519654 as select v12 from aggJoin4355424958592999757 group by v12;
create or replace view aggJoin2809599826592933001 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView5056653734257519654 where mk.movie_id=aggView5056653734257519654.v12;
create or replace view aggView8317173388963604692 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin444520922446056027 as select v12 from aggJoin2809599826592933001 join aggView8317173388963604692 using(v18);
create or replace view aggView9007008410735278191 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5110827301483416439 as select v31 from aggJoin444520922446056027 join aggView9007008410735278191 using(v12);
select MIN(v31) as v31 from aggJoin5110827301483416439;
