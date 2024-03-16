create or replace view aggView2135183945944070497 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin6820911671198636936 as select movie_id as v12 from movie_companies as mc, aggView2135183945944070497 where mc.company_id=aggView2135183945944070497.v1;
create or replace view aggView5833264501841760927 as select v12 from aggJoin6820911671198636936 group by v12;
create or replace view aggJoin2538538208386671818 as select id as v12, title as v20 from title as t, aggView5833264501841760927 where t.id=aggView5833264501841760927.v12;
create or replace view aggView1471843918713896798 as select v12, MIN(v20) as v31 from aggJoin2538538208386671818 group by v12;
create or replace view aggJoin6015964548517706229 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1471843918713896798 where mk.movie_id=aggView1471843918713896798.v12;
create or replace view aggView5990527535404063530 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2141949825780265452 as select v31 from aggJoin6015964548517706229 join aggView5990527535404063530 using(v18);
select MIN(v31) as v31 from aggJoin2141949825780265452;
