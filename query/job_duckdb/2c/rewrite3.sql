create or replace view aggView1862679926316140734 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin4138414535028497109 as select movie_id as v12 from movie_companies as mc, aggView1862679926316140734 where mc.company_id=aggView1862679926316140734.v1;
create or replace view aggView6717169931172230539 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5959525939694564706 as select v12, v31 from aggJoin4138414535028497109 join aggView6717169931172230539 using(v12);
create or replace view aggView1835703380792846896 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7346167548747096728 as select movie_id as v12 from movie_keyword as mk, aggView1835703380792846896 where mk.keyword_id=aggView1835703380792846896.v18;
create or replace view aggView5331117563816591052 as select v12, MIN(v31) as v31 from aggJoin5959525939694564706 group by v12,v31;
create or replace view aggJoin1390309955210690149 as select v31 from aggJoin7346167548747096728 join aggView5331117563816591052 using(v12);
select MIN(v31) as v31 from aggJoin1390309955210690149;
